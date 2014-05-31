class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.boolean 	:active, :default => true
      t.references 	:category
      t.string 		:name
      t.integer 	:position, :unique => true
      t.string		:slug

      t.timestamps
    end
    add_index(:subcategories, :slug)
  end
end
