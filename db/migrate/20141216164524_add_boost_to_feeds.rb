class AddBoostToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :boost, :float, default: 1.0, null: false
  end
end
