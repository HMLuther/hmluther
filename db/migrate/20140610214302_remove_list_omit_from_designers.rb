class RemoveListOmitFromDesigners < ActiveRecord::Migration
  def change
  	remove_column :designers, :list_omit
  end
end
