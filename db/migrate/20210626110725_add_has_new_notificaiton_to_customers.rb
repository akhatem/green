class AddHasNewNotificaitonToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :has_new_notification, :boolean, default: false
    end
end
