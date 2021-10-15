class RenameDescriptionToBodyInPushNotifications < ActiveRecord::Migration[6.1]
  def change
    rename_column :push_notifications, :description, :body
  end
end
