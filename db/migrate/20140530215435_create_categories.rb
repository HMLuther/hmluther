class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.boolean 	:active, :default => true
      t.string 		:name
      t.integer 	:position, :unique => true
      t.string 		:slug

      t.timestamps
    end
    add_index(:categories, :slug)
  end
end
