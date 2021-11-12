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

ActiveRecord::Schema.define(version: 2021_11_12_045344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "enchants", force: :cascade do |t|
    t.string "name"
    t.integer "bonus"
    t.string "imbue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "heros", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "life"
    t.integer "gold"
    t.integer "renown"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_heros_on_user_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.bigint "hero_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hero_id"], name: "index_inventories_on_hero_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.string "element"
    t.bigint "inventory_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inventory_id"], name: "index_items_on_inventory_id"
  end

  create_table "listings", force: :cascade do |t|
    t.bigint "hero_id", null: false
    t.bigint "item_id", null: false
    t.bigint "weapon_id", null: false
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hero_id"], name: "index_listings_on_hero_id"
    t.index ["item_id"], name: "index_listings_on_item_id"
    t.index ["weapon_id"], name: "index_listings_on_weapon_id"
  end

  create_table "qualities", force: :cascade do |t|
    t.string "name"
    t.integer "modifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.integer "damage"
    t.integer "durability"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.bigint "quality_id", null: false
    t.bigint "type_id", null: false
    t.bigint "enchant_id", null: false
    t.integer "uses", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "inventory_id", null: false
    t.index ["enchant_id"], name: "index_weapons_on_enchant_id"
    t.index ["inventory_id"], name: "index_weapons_on_inventory_id"
    t.index ["quality_id"], name: "index_weapons_on_quality_id"
    t.index ["type_id"], name: "index_weapons_on_type_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "heros", "users"
  add_foreign_key "inventories", "heros"
  add_foreign_key "items", "inventories"
  add_foreign_key "listings", "heros"
  add_foreign_key "listings", "items"
  add_foreign_key "listings", "weapons"
  add_foreign_key "weapons", "enchants"
  add_foreign_key "weapons", "inventories"
  add_foreign_key "weapons", "qualities"
  add_foreign_key "weapons", "types"
end
