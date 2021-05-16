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

ActiveRecord::Schema.define(version: 2021_05_16_202524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.bigint "log_id"
    t.string "action_name", null: false
    t.string "controller_name", null: false
    t.string "country_code"
    t.string "format", null: false
    t.string "ip", null: false
    t.string "user_agent", null: false
    t.datetime "timestamp", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["log_id"], name: "index_entries_on_log_id"
  end

  create_table "logs", force: :cascade do |t|
    t.integer "priority", null: false
    t.string "syslog_version", null: false
    t.datetime "timestamp", null: false
    t.string "host", null: false
    t.string "app_name", null: false
    t.string "process_name", null: false
    t.text "message", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "entries", "logs"
end
