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

ActiveRecord::Schema[7.0].define(version: 2023_08_06_093125) do
  create_table "consultations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "consultant_id", null: false
    t.bigint "requester_id", null: false
    t.text "request_content", null: false
    t.datetime "answer_deadline", null: false
    t.integer "status", default: 0, null: false
    t.boolean "is_read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultant_id"], name: "index_consultations_on_consultant_id"
    t.index ["requester_id"], name: "index_consultations_on_requester_id"
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "consultation_id", null: false
    t.text "content", null: false
    t.boolean "is_read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_id"], name: "index_messages_on_consultation_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username", null: false
    t.date "birthdate"
    t.string "gender"
    t.string "profession"
    t.text "profile"
    t.string "profile_image_id"
    t.text "skill"
    t.string "rating"
    t.boolean "is_consultant", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consultations", "users", column: "consultant_id"
  add_foreign_key "consultations", "users", column: "requester_id"
  add_foreign_key "messages", "consultations"
  add_foreign_key "messages", "users", column: "sender_id"
end
