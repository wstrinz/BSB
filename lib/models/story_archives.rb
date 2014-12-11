class StoryArchive < ActiveRecord::Base
  def self.instance
    StoryArchive.first || StoryArchive.create
  end

  def self.archive_story(story)
    require 'pry'; binding.pry
    instance
  end

  def self.in_archive?(url)
    instance
  end
end
