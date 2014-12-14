class CreateShortcuts < ActiveRecord::Migration
  def change
    create_table :shortcuts do |t|
      t.string :key, null: false
      t.string :action, null: false
    end
  end
end
