class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :position, :unique => true
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
