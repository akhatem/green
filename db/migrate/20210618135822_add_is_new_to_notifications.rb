class AddIsNewToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :is_new?, :boolean, default: false
  end
end
