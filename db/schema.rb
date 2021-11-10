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

ActiveRecord::Schema.define(version: 2021_11_10_040441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enchants", force: :cascade do |t|
    t.string "name"
    t.integer "bonus"
    t.string "imbue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.bigint "quality_id", null: false
    t.bigint "type_id", null: false
    t.bigint "enchant_id", null: false
    t.integer "uses", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["enchant_id"], name: "index_weapons_on_enchant_id"
    t.index ["quality_id"], name: "index_weapons_on_quality_id"
    t.index ["type_id"], name: "index_weapons_on_type_id"
  end

  add_foreign_key "weapons", "enchants"
  add_foreign_key "weapons", "qualities"
  add_foreign_key "weapons", "types"
end
