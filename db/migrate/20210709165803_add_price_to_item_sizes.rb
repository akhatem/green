class AddPriceToItemSizes < ActiveRecord::Migration[6.1]
  def change
    add_column :item_sizes, :price, :decimal, precision: 10, scale: 2
  end
end
