# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_23_152012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.integer "value_type"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clubs_patch_types", id: false, force: :cascade do |t|
    t.bigint "club_id", null: false
    t.bigint "patch_type_id", null: false
    t.index ["club_id", "patch_type_id"], name: "index_clubs_patch_types_on_club_id_and_patch_type_id"
    t.index ["patch_type_id", "club_id"], name: "index_clubs_patch_types_on_patch_type_id_and_club_id"
  end

  create_table "configs", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "club_id"
    t.integer "order_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "patch_type_id"
    t.integer "approval_status"
  end

  create_table "orders", force: :cascade do |t|
    t.string "transaction_id"
    t.string "email"
    t.integer "status"
    t.string "token"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patch_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
