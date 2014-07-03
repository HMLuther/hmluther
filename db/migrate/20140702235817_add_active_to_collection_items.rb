class AddActiveToCollectionItems < ActiveRecord::Migration
  def change
  	add_column :collection_items, :active, :boolean, :default => true
  end
end
