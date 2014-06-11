class AddListedCategoryAndListedDesignerToItems < ActiveRecord::Migration
  def change
  	add_column :items, :listed_category, :boolean, :default => true
  	add_column :items, :listed_designer, :boolean, :default => true
  end
end
