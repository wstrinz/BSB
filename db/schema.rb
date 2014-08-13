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

ActiveRecord::Schema.define(version: 20140813025546) do

  create_table "feeds", force: true do |t|
    t.string "name",     null: false
    t.string "feed_url", null: false
    t.string "type"
  end

  create_table "stories", force: true do |t|
    t.string   "url"
    t.string   "author"
    t.datetime "updated"
    t.datetime "published"
    t.text     "summary"
    t.text     "story_content"
    t.integer  "feed_id"
    t.string   "title"
    t.datetime "fetched_at"
    t.datetime "timestamp"
    t.boolean  "read",          default: false
  end

end
