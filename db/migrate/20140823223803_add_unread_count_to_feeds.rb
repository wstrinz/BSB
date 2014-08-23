class AddUnreadCountToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :unread_count, :integer
  end
end
