class ChangeDesignerListColumnNames < ActiveRecord::Migration
  def change
  	rename_column :designers, :include, :list_include
  	rename_column :designers, :omit, :list_omit
  end
end
