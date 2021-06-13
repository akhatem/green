class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :key
      t.text :description
      t.boolean :is_super, default: false

      t.timestamps
    end
  end
end
