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

ActiveRecord::Schema.define(version: 2018_12_27_025617) do

  create_table "hero_picks", force: :cascade do |t|
    t.string "picked_by"
    t.integer "match_id"
    t.integer "hero_id"
  end

  create_table "heroes", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.integer "on_list"
  end

  create_table "maps", force: :cascade do |t|
    t.string "name"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "result"
    t.integer "map_id"
    t.integer "replay_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "battletag"
    t.integer "last_import"
    t.integer "region"
    t.text "list_type"
  end

end
