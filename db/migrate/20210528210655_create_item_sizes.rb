class CreateItemSizes < ActiveRecord::Migration[6.1]
  def change
    create_table :item_sizes do |t|
      t.references :item, index: true, null: false, foreign_key: true
      t.references :size, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
