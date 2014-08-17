class AddCreatedAtToStories < ActiveRecord::Migration
  def change
    add_column :stories, :created_at, :datetime
  end
end
