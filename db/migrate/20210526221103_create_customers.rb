# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      ## Database authenticatable
      t.string :name,               null: false, blank: false
      t.string :mobile,             null: false, unique: true, blank: false
      t.string :password,           null: false, default: "", blank: false
      t.string :password_digest,    null: false, default: ""
      t.string :email,              null: true
      t.string :token,              unique: true
      t.string :barcode,            unique: true
      t.integer :points,            null: false, default: 0
      t.boolean :is_active,   null: false, default: false
      t.string :verification_code

      
      t.timestamps null: false
    end

    add_index :customers, :mobile,               unique: true
    add_index :customers, :token,                unique: true
    add_index :customers, :barcode,         unique: true
  end
end
