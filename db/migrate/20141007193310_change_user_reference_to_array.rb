class ChangeUserReferenceToArray < ActiveRecord::Migration
  def change
  	remove_column :users, :reference
  	add_column :users, :reference, :string, array: true, default: []
  end
end
