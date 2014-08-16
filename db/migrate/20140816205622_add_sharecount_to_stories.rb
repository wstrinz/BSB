class AddSharecountToStories < ActiveRecord::Migration
  def change
    add_column :stories, :sharecount, :integer
  end
end
