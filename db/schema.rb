# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140118214529) do

  create_table "actions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action_code"
    t.string   "result_type"
    t.integer  "custom_display_order"
  end

  create_table "cards", force: true do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["match_id"], name: "index_cards_on_match_id"
  add_index "cards", ["user_id"], name: "index_cards_on_user_id"

  create_table "cells", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
  end

  add_index "cells", ["round_id"], name: "index_cells_on_round_id"

  create_table "events", force: true do |t|
    t.integer  "cell_id"
    t.integer  "action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["action_id"], name: "index_events_on_action_id"
  add_index "events", ["cell_id"], name: "index_events_on_cell_id"

  create_table "fighters", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fighters", ["user_id"], name: "index_fighters_on_user_id"

  create_table "matches", force: true do |t|
    t.datetime "original_fight_date"
    t.integer  "venue_id"
    t.integer  "total_rounds"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "redcorner_id"
    t.integer  "bluecorner_id"
  end

  add_index "matches", ["user_id"], name: "index_matches_on_user_id"
  add_index "matches", ["venue_id"], name: "index_matches_on_venue_id"

  create_table "rounds", force: true do |t|
    t.integer  "card_id"
    t.integer  "round_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "redcornercell_id"
    t.integer  "bluecornercell_id"
  end

  add_index "rounds", ["card_id"], name: "index_rounds_on_card_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "venues", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "street_address"
    t.string   "extended_address"
    t.string   "locality"
    t.string   "region"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
