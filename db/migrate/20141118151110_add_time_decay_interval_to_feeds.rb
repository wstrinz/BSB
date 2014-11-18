class AddTimeDecayIntervalToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :time_decay_interval, :integer, null: false, default: 24
  end
end
