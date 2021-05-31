class CreatePointsMovements < ActiveRecord::Migration[6.1]
  def change
    create_table :points_movements do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :branch, null: false, foreign_key: true
      t.integer :redeemed, default: 0
      t.integer :earned, default: 0
      t.datetime :date_time, null: false
      t.integer :total, default: 0
      t.integer :current_points, default: 0

      t.timestamps
    end
  end
end
