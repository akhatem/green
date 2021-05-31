class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.string :name, null: false
      t.text :description, blank: false

      t.timestamps
    end
  end
end
