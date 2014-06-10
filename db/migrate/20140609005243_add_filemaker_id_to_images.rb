class AddFilemakerIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :filemaker_id, :string
  end
end
