class Feed < ActiveRecord::Base
  has_many :stories

  def update
    f = Feedjira::Feed.fetch_and_parse self.feed_url

    unless f.class.parent == Feedjira::Parser
      logger.info "Error fetching feed for #{self.feed_url}"
      return
    end

    if self.name != f.title
      self.name = f.title
      self.save
    end

    update_count = 0
    f.entries.each do |e|
      if Story.where(url: e.url).empty?
        update_count += 1
        s = Story.from_entry(e)
        s.feed = self
        s.save
        s.update_sharecount
      end
    end
    logger.info "Feed #{name} updated #{update_count} stories"
  end

  def update_stats
    self.unread_count = stories.where(read: false).count
    self.save
  end
end
