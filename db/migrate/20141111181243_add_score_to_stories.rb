class AddScoreToStories < ActiveRecord::Migration
  def change
    add_column :stories, :score, :integer, null: false, default: 0
  end
end
