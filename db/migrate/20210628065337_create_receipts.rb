class CreateReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :receipts do |t|
      t.references :customer, null: false, index: true, foreign_key: true,   
                                                               comment: "Receipt belongs to a customer"
      t.references :branch, null: false, index: true, foreign_key: true,   
                                                               comment: "Receipt belongs to a branch"
      t.references :user, null: false, index: true, foreign_key: true,   
                                                               comment: "Receipt belongs to a user(Role: cashier)"
      t.string :number, null: false, index: true
      t.decimal :total_price


      t.timestamps
    end
  end
end
