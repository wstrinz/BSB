class AddStoryArchives < ActiveRecord::Migration
  def change
    create_table :story_archives do |t|
      t.string :archived_urls, array: true, default: []
    end
  end
end
