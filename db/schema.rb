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

ActiveRecord::Schema.define(version: 20140805013742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collection_items", force: true do |t|
    t.integer  "collection_id"
    t.string   "item_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        default: true
  end

  add_index "collection_items", ["collection_id"], name: "index_collection_items_on_collection_id", using: :btree
  add_index "collection_items", ["item_id"], name: "index_collection_items_on_item_id", using: :btree

  create_table "collections", force: true do |t|
    t.integer  "user_id"
    t.boolean  "active",      default: true
    t.string   "name"
    t.text     "description"
    t.boolean  "public",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree

  create_table "designers", force: true do |t|
    t.string   "name_first"
    t.text     "bio"
    t.boolean  "active",          default: true
    t.boolean  "listed",          default: false
    t.string   "production_date"
    t.string   "website"
    t.string   "filemaker_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "origin"
    t.string   "name_last"
  end

  add_index "designers", ["filemaker_id"], name: "index_designers_on_filemaker_id", using: :btree
  add_index "designers", ["slug"], name: "index_designers_on_slug", using: :btree

  create_table "images", force: true do |t|
    t.integer  "item_id"
    t.boolean  "active",       default: true
    t.boolean  "banner",       default: false
    t.string   "image_type"
    t.integer  "position"
    t.boolean  "primary",      default: false
    t.boolean  "thumb",        default: false
    t.string   "url"
    t.boolean  "webcomp",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filemaker_id"
    t.string   "slug"
    t.string   "file_type"
    t.string   "preview_url"
  end

  add_index "images", ["filemaker_id"], name: "index_images_on_filemaker_id", using: :btree
  add_index "images", ["item_id"], name: "index_images_on_item_id", using: :btree

  create_table "items", force: true do |t|
    t.integer  "subcategory_id"
    t.boolean  "active",               default: true
    t.string   "circa"
    t.string   "depth_in"
    t.text     "description"
    t.string   "description_short"
    t.string   "diameter_in"
    t.string   "filemaker_id"
    t.string   "height_in"
    t.string   "location"
    t.text     "reference"
    t.boolean  "sold",                 default: false
    t.string   "width_in"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",             default: false
    t.string   "slug"
    t.boolean  "listed_category",      default: true
    t.boolean  "listed_designer",      default: true
    t.string   "depth_cm"
    t.string   "diameter_cm"
    t.string   "height_cm"
    t.string   "width_cm"
    t.integer  "size"
    t.string   "designer_connector_1"
    t.string   "designer_connector_2"
  end

  add_index "items", ["filemaker_id"], name: "index_items_on_filemaker_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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
    t.integer  "role"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "phone"
    t.text     "reference"
    t.string   "state"
    t.string   "zip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
