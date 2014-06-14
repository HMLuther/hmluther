class AddOriginToDesigners < ActiveRecord::Migration
  def change
  	add_column :designers, :origin, :string
  end
end
