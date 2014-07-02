class ChangeDesignerNameToFirstAndLast < ActiveRecord::Migration
  def change
  	add_column :designers, :name_last, :string
  	rename_column :designers, :name, :name_first
  end
end
