class AddReceiptIdToPointsMovements < ActiveRecord::Migration[6.1]
  def change
    add_reference :points_movements, :receipt, null: false, foreign_key: true
  end
end
