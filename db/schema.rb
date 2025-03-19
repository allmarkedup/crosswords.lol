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

ActiveRecord::Schema[8.0].define(version: 2025_03_19_202604) do
  create_table "accounts", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.integer "account_id"
    t.integer "crossword_id"
    t.text "values", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "synced_at"
    t.datetime "completed_at"
    t.text "events"
    t.text "timer"
    t.index ["account_id"], name: "index_answers_on_account_id"
    t.index ["crossword_id"], name: "index_answers_on_crossword_id"
  end

  create_table "crosswords", force: :cascade do |t|
    t.string "crossword_type", default: "quick"
    t.integer "column_count", null: false
    t.integer "row_count", null: false
    t.text "entries", null: false
    t.string "provider_name"
    t.string "provider_reference"
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "number"
    t.index ["number"], name: "index_crosswords_on_number", unique: true
  end

  create_table "imports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
