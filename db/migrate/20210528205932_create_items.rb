class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, blank: false,              comment: "Name of the item"
      t.string :description, blank: false,                    comment: "Item details"
      t.string :image, null: false,                           comment: "Item Image"
      
      t.references :brand, null: false, index: true, foreign_key: true,     
                                                               comment: "Each item belongs to a brand"
      
      t.references :category, null: false, index: true, foreign_key: true,   
                                                               comment: "Each item belongs to a category"

      t.timestamps
    end
  end
end
