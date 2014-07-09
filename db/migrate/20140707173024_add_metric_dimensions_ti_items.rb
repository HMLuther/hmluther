class AddMetricDimensionsTiItems < ActiveRecord::Migration
  def change
  	add_column :items, :depth_cm, :string
  	add_column :items, :diameter_cm, :string
  	add_column :items, :height_cm, :string
  	add_column :items, :width_cm, :string
  	add_column :items, :size, :integer
  end
end
