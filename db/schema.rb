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

ActiveRecord::Schema.define(version: 2020_03_20_115227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_teams", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "user_id"
    t.boolean "spy"
    t.string "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "validated"
    t.index ["game_id"], name: "index_game_teams_on_game_id"
    t.index ["user_id"], name: "index_game_teams_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "red"
    t.integer "blue"
    t.string "status"
    t.string "name"
    t.bigint "user_id"
    t.string "turn"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "word_games", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "word_id"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "discovered"
    t.index ["game_id"], name: "index_word_games_on_game_id"
    t.index ["word_id"], name: "index_word_games_on_word_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "game_teams", "games"
  add_foreign_key "game_teams", "users"
  add_foreign_key "games", "users"
  add_foreign_key "word_games", "games"
  add_foreign_key "word_games", "words"
end
