class AddTimeDecayFlagToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :time_decay, :boolean, null: false, default: false
  end
end
