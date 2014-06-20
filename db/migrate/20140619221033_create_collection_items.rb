class CreateCollectionItems < ActiveRecord::Migration
  def change
    create_table :collection_items do |t|
    	t.references	:collection
    	t.references	:item
      t.integer :position

      t.timestamps
    end
    add_index :collection_items, :collection_id
    add_index :collection_items, :item_id
  end
end
