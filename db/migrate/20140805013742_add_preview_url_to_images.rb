class AddPreviewUrlToImages < ActiveRecord::Migration
  def change
    add_column :images, :preview_url, :string
  end
end
