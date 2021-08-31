class ChangeIndexInReceipts < ActiveRecord::Migration[6.1]
  def change
    change_column(:receipts, :number, :string, null: false, index: false)
  end
end
