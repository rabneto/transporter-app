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

ActiveRecord::Schema[7.0].define(version: 2023_01_25_034756) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "min_range"
    t.integer "max_range"
    t.integer "hours"
    t.integer "transport_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_mode_id"], name: "index_deadlines_on_transport_mode_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.datetime "start"
    t.datetime "deadline"
    t.datetime "delivered"
    t.string "delay_reason"
    t.integer "distance"
    t.string "product_id"
    t.integer "product_width"
    t.integer "product_height"
    t.integer "product_depth"
    t.integer "product_weight"
    t.string "origin_address"
    t.string "origin_city"
    t.string "origin_uf"
    t.string "destiny_address"
    t.string "destiny_city"
    t.string "destiny_uf"
    t.string "recipient_document"
    t.string "recipient_email"
    t.string "recipient_phone"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.string "recipient_name"
    t.string "sender_name"
    t.string "sender_document"
    t.string "sender_phone"
    t.string "sender_email"
    t.integer "transport_mode_id"
    t.integer "vehicle_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.decimal "km_price"
    t.integer "transport_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_mode_id"], name: "index_prices_on_transport_mode_id"
  end

  create_table "transport_modes", force: :cascade do |t|
    t.string "name"
    t.integer "min_range"
    t.integer "max_range"
    t.integer "min_weight"
    t.integer "max_weight"
    t.decimal "tax"
    t.integer "active", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.string "brand"
    t.string "model"
    t.integer "year"
    t.integer "max_weight"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
    t.index ["category_id"], name: "index_vehicles_on_category_id"
  end

  add_foreign_key "deadlines", "transport_modes"
  add_foreign_key "prices", "transport_modes"
  add_foreign_key "vehicles", "categories"
end
