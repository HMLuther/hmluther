class AddConnectorsToItems < ActiveRecord::Migration
  def change
    add_column :items, :designer_connector_1, :string
    add_column :items, :designer_connector_2, :string
  end
end
