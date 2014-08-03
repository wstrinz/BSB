class AddReadToStories < ActiveRecord::Migration
  def change
    add_column :stories, :read, :boolean, default: false
  end
end
