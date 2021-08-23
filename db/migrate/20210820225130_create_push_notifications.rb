class CreatePushNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :push_notifications do |t|

      t.string :title
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
