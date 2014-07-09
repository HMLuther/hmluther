class ChangeDimensionsOnItems < ActiveRecord::Migration
  def change
  	rename_column :items, :depth, :depth_in
  	rename_column :items, :diameter, :diameter_in
  	rename_column :items, :height, :height_in
  	rename_column :items, :width, :width_in
  end
end
