class AddFetchedAtToStories < ActiveRecord::Migration
  def change
    add_column :stories, :fetched_at, :datetime
  end
end
