class StoryArchive < ActiveRecord::Base
  def self.instance
    @instance ||= (StoryArchive.first || StoryArchive.create)
  end

  def self.archive(story)
    instance.archived_urls << story.url
    instance.archived_urls_will_change!
    instance.save
  end

  def self.contains?(url)
    where(['? = ANY(archived_urls)', url]).present?
  end
end
