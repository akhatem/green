class RemovePriceFromSizes < ActiveRecord::Migration[6.1]
  def change
    remove_column :sizes, :price, :decimal
  end
end
