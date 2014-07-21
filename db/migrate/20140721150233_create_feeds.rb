class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name, null: false
      t.string :feed_url, null: false
    end
  end
end
