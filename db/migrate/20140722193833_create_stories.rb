class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :url
      t.string :author
      t.datetime :updated
      t.datetime :published
      t.text :summary
      t.text :content
    end
  end
end
