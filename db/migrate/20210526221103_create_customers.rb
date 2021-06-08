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
      t.text :barcode_data,            unique: true
      t.integer :points,            null: false, default: 0
      t.boolean :is_activated?,   null: false, default: false
      t.string :verification_code,  null: false
      
      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :customers, :mobile,               unique: true
  end
end
