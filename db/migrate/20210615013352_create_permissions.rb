class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.string :action
      t.string :class_name
      t.text :description
      t.boolean :is_super, default: false

      t.timestamps
    end
  end
end
