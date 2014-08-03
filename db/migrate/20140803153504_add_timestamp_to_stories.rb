class AddTimestampToStories < ActiveRecord::Migration
  def change
    add_column :stories, :timestamp, :datetime
  end
end
