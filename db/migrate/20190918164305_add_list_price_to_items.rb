class AddListPriceToItems < ActiveRecord::Migration[5.2]
  def change
    add_monetize :items, :list_price
  end
end
