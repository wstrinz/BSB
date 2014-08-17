class AddUpdatedAtToStories < ActiveRecord::Migration
  def change
    add_column :stories, :updated_at, :datetime
  end
end
