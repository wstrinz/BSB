class Story < ActiveRecord::Base
  belongs_to :feed
  has_many :keywords
  after_save :update_feed_stats

  def self.from_entry(e)
    model_only = %w{id feed_id story_content fetched_at timestamp read}
    props = (attribute_names - model_only).each_with_object({}) do |a, h|
      h[a.to_sym] = e.send(a.to_sym) if e.respond_to? a.to_sym
    end

    props[:story_content] = e.content
    props[:fetched_at] = Time.now

    if props[:published]
      props[:timestamp] = props[:published]
    else
      props[:timestamp] = props[:fetched_at]
    end

    props[:created_at] = Time.now
    props[:updated_at] = Time.now

    create!(props)
  end

  def self.refresh_sharecounts
    key = ENV['sharedcount']
    resp = JSON.parse Curl.get('http://free.sharedcount.com/quota', {apikey: key}).body_str
    remaining = resp["quota_allocated_today"]
    amt = remaining * 0.02
    to_refresh = [Story.where(read: false).count, amt.to_i].min
    Story.where(read: false).order(:updated_at).limit(to_refresh).each do |s|
      s.update_sharecount
    end
  end

  def self.archive_read_stories
    Story.where(read: true).map(&:archive!)
  end

  def self.archive_old_stories_if_needed(max: ENV['DB_ROW_MAX'], margin: ENV['DB_ROW_MARGIN'], criterion: :created_at, direction: :asc)
    archive_read_stories

    max = max.to_i
    margin = margin.to_i
    max ||= -1
    margin ||= 1000
    if max < 1
      logger.info "No max row count specified, ignoring"
      return
    end

    row_count = ActiveRecord::Base.send(:subclasses).map{|m| m.all.size}.reduce(&:+)

    if row_count + margin >= max
      num_to_delete = row_count - (max - margin) + 1
      Story.order(criterion => direction).limit(num_to_delete).map(&:archive!)
      logger.info "Destroyed #{num_to_delete} old stories"
    else
      logger.info "Only #{row_count} rows exist, deletion will not happen unless #{max - margin} is reached"
    end
  end

  def archive!
    StoryArchive.archive(self)
    self.destroy
  end

  def update_sharecount
    key = ENV['sharedcount']
    response = Curl.get('http://free.sharedcount.com/', {apikey: key, url: self.url})

    data = JSON.parse response.body_str
    if data["Error"]
      logger.info("failed to fetch share count for #{self.url}: \n\t #{data["Error"]}")
    else
      self.sharecount = data.except("Facebook").values.sum + data["Facebook"].values.sum
      self.updated_at = Time.now
      save!
    end
  end

  def time_decay_sharecount
    if self.sharecount.present? && self.timestamp.present?
      elapsed_interval_hours = ((Time.now - self.timestamp) / feed.time_decay_interval.hours).round
      decayed_count = sharecount / ((elapsed_interval_hours + 1) ** 1.5)
      (decayed_count + 1).round
    else
      sharecount
    end
  end

  def recompute_score
    if self.feed.time_decay
      self.score = time_decay_sharecount || 1
    else
      self.score = self.sharecount || 1
    end

    self.score *= self.feed.boost
  end

  def update_feed_stats
    feed.update_stats if feed
  end

  def generate_keywords
    sanitized_content = Sanitize.clean(story_content)
    tokens = sanitized_content.split.reject do |token|
      token[/[^0-9a-z]/i] || Keyword::STOP_WORDS.include?(token)
    end.map do |token|
      Stemmer::stem_word(token).downcase
    end

    frequencies = tokens.each_with_object(Hash.new(0)) do |word, memo|
      memo[word] += 1
    end

    frequencies.sort_by{|word, count| count}.first(3).each do |kwd|
      # keywords.create(name: kwd.first.downcase.gsub(/([^[:alpha:]]+)|((?=\w*[a-z])(?=\w*[0-9])\w+)/, ''))
    end

    frequencies.sort_by{|word, count| count}.reverse.first(3)
  end
end
