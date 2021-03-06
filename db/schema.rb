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

ActiveRecord::Schema.define(version: 20181124132425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "camp_id"
    t.integer  "user_id"
    t.boolean  "organiser",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camps", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "location",   limit: 255
    t.boolean  "current"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone",  limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
  end

  create_table "discussions", force: :cascade do |t|
    t.string   "path",       limit: 255
    t.integer  "camp_id"
    t.string   "title",      limit: 255
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "camp_id"
    t.string   "type",        limit: 255
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "thought_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["user_id", "thought_id"], name: "index_likes_on_user_id_and_thought_id", unique: true, using: :btree

  create_table "notices", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content"
    t.integer  "user_id"
    t.integer  "camp_id"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.boolean  "help"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "closed_at"
    t.datetime "status_changed_at"
    t.string   "status",            limit: 255, default: "active", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 255
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "talks", force: :cascade do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "camp_id"
  end

  create_table "thought_processes", force: :cascade do |t|
    t.integer  "thought_id"
    t.integer  "evolution_id"
    t.string   "evolution_type", limit: 255
    t.datetime "evolved_at"
  end

  create_table "thoughts", force: :cascade do |t|
    t.text     "description"
    t.boolean  "dead"
    t.integer  "ancestor_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes_count"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "twitter",    limit: 255
    t.text     "bio"
    t.integer  "camp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bonjour",    limit: 255
    t.string   "irc",        limit: 255
    t.string   "avatar",     limit: 255
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "camp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
