# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_09_165803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.decimal "long"
    t.decimal "lat"
    t.string "address"
    t.bigint "city_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_branches_on_city_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "brand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_categories_on_brand_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "mobile", null: false
    t.string "password", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.string "email"
    t.string "token"
    t.string "barcode"
    t.integer "points", default: 0, null: false
    t.boolean "is_activated?", default: false, null: false
    t.string "verification_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.binary "decoded_barcode"
    t.boolean "has_new_notification", default: false
    t.index ["mobile"], name: "index_customers_on_mobile", unique: true
    t.index ["token"], name: "index_customers_on_token", unique: true
  end

  create_table "item_sizes", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "size_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", precision: 10, scale: 2
    t.index ["item_id"], name: "index_item_sizes_on_item_id"
    t.index ["size_id"], name: "index_item_sizes_on_size_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false, comment: "Name of the item"
    t.string "description", comment: "Item details"
    t.string "image", comment: "Item Image"
    t.bigint "brand_id", null: false, comment: "Each item belongs to a brand"
    t.bigint "category_id", null: false, comment: "Each item belongs to a category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "create_date"
    t.integer "offer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_new", default: true
  end

  create_table "offers", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "state", default: 1, null: false
    t.date "start_at", null: false
    t.date "end_at", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_default", default: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "action"
    t.string "class_name"
    t.text "description"
    t.boolean "is_super", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "points_movements", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "branch_id", null: false
    t.integer "redeemed", default: 0
    t.integer "earned", default: 0
    t.datetime "date_time", null: false
    t.integer "total", default: 0
    t.integer "current_points", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["branch_id"], name: "index_points_movements_on_branch_id"
    t.index ["customer_id"], name: "index_points_movements_on_customer_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.bigint "customer_id", null: false, comment: "Receipt belongs to a customer"
    t.bigint "branch_id", null: false, comment: "Receipt belongs to a branch"
    t.bigint "user_id", null: false, comment: "Receipt belongs to a user(Role: cashier)"
    t.string "number", null: false
    t.decimal "total_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["branch_id"], name: "index_receipts_on_branch_id"
    t.index ["customer_id"], name: "index_receipts_on_customer_id"
    t.index ["number"], name: "index_receipts_on_number"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.text "description"
    t.boolean "is_super", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["permission_id"], name: "index_roles_permissions_on_permission_id"
    t.index ["role_id"], name: "index_roles_permissions_on_role_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sms_messages", force: :cascade do |t|
    t.string "mobile"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "role_id", null: false
    t.bigint "branch_id"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["branch_id"], name: "index_users_on_branch_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "categories", "brands"
  add_foreign_key "item_sizes", "items"
  add_foreign_key "item_sizes", "sizes"
  add_foreign_key "items", "brands"
  add_foreign_key "items", "categories"
  add_foreign_key "points_movements", "branches"
  add_foreign_key "points_movements", "customers"
  add_foreign_key "receipts", "branches"
  add_foreign_key "receipts", "customers"
  add_foreign_key "receipts", "users"
  add_foreign_key "roles_permissions", "permissions"
  add_foreign_key "roles_permissions", "roles"
  add_foreign_key "users", "roles"
end
