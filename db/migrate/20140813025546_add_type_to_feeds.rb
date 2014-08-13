class AddTypeToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :type, :string
  end
end
