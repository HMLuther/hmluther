class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
    	t.references :user
      t.boolean :active, :default => true
      t.string :name
      t.text :description
      t.boolean :public, :default => false

      t.timestamps
    end
    add_index(:collections, :user_id)
  end
end
