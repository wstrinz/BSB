class AddFeedIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :feed_id, :integer
  end
end
