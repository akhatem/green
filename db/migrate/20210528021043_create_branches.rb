class CreateBranches < ActiveRecord::Migration[6.1]
  def change
    create_table :branches do |t|
      t.string :name, blank: false
      t.string :link
      t.decimal :long
      t.decimal :lat
      t.string :address, blank: false
      t.references :city, blank: false

      t.timestamps
    end
  end
end
