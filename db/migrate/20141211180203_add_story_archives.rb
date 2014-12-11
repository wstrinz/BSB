class AddStoryArchives < ActiveRecord::Migration
  def change
    create_table :story_archives do |t|
      t.string :archived_urls, array: true, default: '{}'
    end

    add_index :story_archives, :archived_urls, using: 'GIN'
  end
end
