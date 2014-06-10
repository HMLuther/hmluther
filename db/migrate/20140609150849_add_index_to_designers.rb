class AddIndexToDesigners < ActiveRecord::Migration
  def change
    add_index(:designers, :filemaker_id)
  end
end
