class RenameIsActiveInCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :is_active, :is_activated?
  end
end
