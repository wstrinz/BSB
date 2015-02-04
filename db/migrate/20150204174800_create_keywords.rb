class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name, null: false
      t.integer :story_id
    end
  end
end
