class AddPriceCentsToItems < ActiveRecord::Migration[5.2]
  def change
    add_monetize :items, :price
  end
end
