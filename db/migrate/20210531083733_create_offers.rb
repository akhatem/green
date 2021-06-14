class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.string :title, blank: false
      t.text :description, blank: false
      t.integer :state, null: false, default: 1
      t.date :start_at, null: false
      t.date :end_at, null: false
      t.string :image
      
      t.timestamps
    end
  end
end
