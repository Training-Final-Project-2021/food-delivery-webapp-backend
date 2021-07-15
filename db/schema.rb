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

ActiveRecord::Schema.define(version: 2021_07_14_154102) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_admins_on_authentication_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "carts", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "hotel_id", null: false
    t.integer "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "item_quantity"
    t.string "item_name"
    t.string "item_price"
    t.string "total_price"
    t.index ["customer_id"], name: "index_carts_on_customer_id"
    t.index ["hotel_id"], name: "index_carts_on_hotel_id"
    t.index ["item_id"], name: "index_carts_on_item_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "phone_no"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_customers_on_authentication_token", unique: true
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "phone_no"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_deliveries_on_authentication_token", unique: true
    t.index ["email"], name: "index_deliveries_on_email", unique: true
    t.index ["reset_password_token"], name: "index_deliveries_on_reset_password_token", unique: true
  end

  create_table "hotels", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "status"
    t.string "address"
    t.string "discription"
    t.string "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_hotels_on_authentication_token", unique: true
    t.index ["email"], name: "index_hotels_on_email", unique: true
    t.index ["reset_password_token"], name: "index_hotels_on_reset_password_token", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.integer "hotel_id", null: false
    t.string "name"
    t.string "price"
    t.string "discription"
    t.string "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "category"
    t.index ["hotel_id"], name: "index_items_on_hotel_id"
  end

  create_table "orders_histories", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "hotel_id", null: false
    t.integer "item_id", null: false
    t.string "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_orders_histories_on_customer_id"
    t.index ["hotel_id"], name: "index_orders_histories_on_hotel_id"
    t.index ["item_id"], name: "index_orders_histories_on_item_id"
  end

  create_table "orders_lists", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "hotel_id", null: false
    t.integer "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.integer "item_quantity"
    t.string "item_name"
    t.string "item_price"
    t.string "total_price"
    t.index ["customer_id"], name: "index_orders_lists_on_customer_id"
    t.index ["hotel_id"], name: "index_orders_lists_on_hotel_id"
    t.index ["item_id"], name: "index_orders_lists_on_item_id"
  end

  create_table "pickup_tables", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "hotel_id", null: false
    t.integer "item_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_pickup_tables_on_customer_id"
    t.index ["hotel_id"], name: "index_pickup_tables_on_hotel_id"
    t.index ["item_id"], name: "index_pickup_tables_on_item_id"
  end

  add_foreign_key "carts", "customers"
  add_foreign_key "carts", "hotels"
  add_foreign_key "carts", "items"
  add_foreign_key "items", "hotels"
  add_foreign_key "orders_histories", "customers"
  add_foreign_key "orders_histories", "hotels"
  add_foreign_key "orders_histories", "items"
  add_foreign_key "orders_lists", "customers"
  add_foreign_key "orders_lists", "hotels"
  add_foreign_key "orders_lists", "items"
  add_foreign_key "pickup_tables", "customers"
  add_foreign_key "pickup_tables", "hotels"
  add_foreign_key "pickup_tables", "items"
end
