class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.references :category
      t.string :name
      t.integer :position, :unique => true
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
