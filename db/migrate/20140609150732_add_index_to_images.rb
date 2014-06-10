class AddIndexToImages < ActiveRecord::Migration
  def change
    add_index(:images, :filemaker_id)
  end
end
