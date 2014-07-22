class Story < ActiveRecord::Base
  belongs_to :feed

  def self.from_entry(e)
    props = (attribute_names - ["id", "feed_id"]).each_with_object({}) do |a, h|
      h[a.to_sym] = e.send(a.to_sym)
    end

    create!(props)
  end
end
