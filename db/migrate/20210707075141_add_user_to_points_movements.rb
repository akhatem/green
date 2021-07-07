class AddUserToPointsMovements < ActiveRecord::Migration[6.1]
  def change
    add_column :points_movements, :user_id, :integer, blank: false
  end
end
