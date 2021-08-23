class AddNotificationIdToPushNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference(:push_notifications, :notification, type: :string)
  end
end
