class AddImageToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :image, :string
  end
end
