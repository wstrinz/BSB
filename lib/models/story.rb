class Story < ActiveRecord::Base
  belongs_to :feed

  def self.from_entry(e)
    model_only = %w{id feed_id story_content fetched_at timestamp model_only}
    props = (attribute_names - model_only).each_with_object({}) do |a, h|
      h[a.to_sym] = e.send(a.to_sym)
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
end
