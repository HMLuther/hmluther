class ChangeItemIdTypecastInCollectionItems < ActiveRecord::Migration
 def self.up
    change_column :collection_items, :item_id, :string
  end
 
  def self.down
    change_column :collection_items, :item_id, :integer
  end
end
