class ChangePriceTypeInSizes < ActiveRecord::Migration[6.1]
  def change
    change_column :sizes, :price, :decimal, :precision => 2
  end
end
