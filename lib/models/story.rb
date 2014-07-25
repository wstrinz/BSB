class Story < ActiveRecord::Base
  belongs_to :feed

  def self.from_entry(e)
    props = (attribute_names - %w{id feed_id story_content}).each_with_object({}) do |a, h|
      h[a.to_sym] = e.send(a.to_sym)
    end

    props[:story_content] = e.content

    create!(props)
  end
end
