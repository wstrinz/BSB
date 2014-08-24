class Story < ActiveRecord::Base
  belongs_to :feed
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

  def update_feed_stats
    feed.update_stats if feed
  end
end
