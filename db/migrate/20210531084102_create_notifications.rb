class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.date :create_date
      t.integer :offer_id, null: true

      t.timestamps
    end
  end
end
