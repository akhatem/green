class AddKeyToSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :settings, :key, :string, unique: true
  end
end
