class RenameListIncludeToListedInDesigners < ActiveRecord::Migration
  def change
  	rename_column :designers, :list_include, :listed
  end
end
