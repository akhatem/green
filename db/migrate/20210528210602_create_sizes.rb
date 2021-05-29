class CreateSizes < ActiveRecord::Migration[6.1]
  def change
    create_table :sizes do |t|
      t.string :name, null: false
      t.decimal :price, null: false

      t.timestamps
    end 
  end
end
