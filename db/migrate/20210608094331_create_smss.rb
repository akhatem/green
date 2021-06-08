class CreateSmss < ActiveRecord::Migration[6.1]
  def change
    create_table :smss do |t|
      t.text :message
      t.string :mobile

      t.timestamps
    end
  end
end
