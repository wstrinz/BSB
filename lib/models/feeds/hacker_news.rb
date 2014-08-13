require 'ruby-hackernews'
class HackerNewsFeed < Feed
  def update
    entries = RubyHackernews::Entry.all
    t = Time.now
    news = entries.select{ |e| Story.where(url: e.link.href).empty? }
    logger.info "Hacker News added #{news.count} stories"
    news.each do |e|
      s = Story.new
      s.feed = self
      s.author = e.user.name
      begin
        s.published = e.time
      rescue
        s.published = Time.now
      end
      #s.story_content = e.text
      s.url = e.link.href
      s.title = "#{e.link.title} - (#{e.link.site})"
      s.fetched_at = t
      s.timestamp = s.published
      s.save!
    end
  end
end
