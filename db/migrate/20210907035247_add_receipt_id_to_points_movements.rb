class AddReceiptIdToPointsMovements < ActiveRecord::Migration[6.1]
  def change
    add_reference :points_movements, :receipt, foreign_key: true
  end
end
