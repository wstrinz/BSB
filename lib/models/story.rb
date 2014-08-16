class Story < ActiveRecord::Base
  belongs_to :feed

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

    create!(props)
  end

  def update_sharecount
    key = ENV['sharedcount_key']
    response = Curl.get('http://free.sharedcount.com/', {apikey: key, url: self.url})

    data = JSON.parse response.body_str
    if data["Error"]
      logger.info("failed to fetch share count for #{self.url}")
    else
      self.sharecount = data.except("Facebook").values.sum + data["Facebook"].values.sum
      save!
    end
  end
end
