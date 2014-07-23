class RenameStoryContent < ActiveRecord::Migration
  def change
    rename_column :stories, :content, :story_content
  end
end
