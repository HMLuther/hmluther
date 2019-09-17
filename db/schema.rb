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

ActiveRecord::Schema.define(version: 2019_09_16_191240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collection_items", force: :cascade do |t|
    t.integer "collection_id"
    t.string "item_id"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "active", default: true
    t.index ["collection_id"], name: "index_collection_items_on_collection_id"
    t.index ["item_id"], name: "index_collection_items_on_item_id"
  end

  create_table "collections", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "active", default: true
    t.string "name"
    t.text "description"
    t.boolean "public", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "designers", force: :cascade do |t|
    t.string "name_first"
    t.text "bio"
    t.boolean "active", default: true
    t.boolean "listed", default: false
    t.string "production_date"
    t.string "website"
    t.string "filemaker_id"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "origin"
    t.string "name_last"
    t.index ["filemaker_id"], name: "index_designers_on_filemaker_id"
    t.index ["slug"], name: "index_designers_on_slug"
  end

  create_table "images", force: :cascade do |t|
    t.integer "item_id"
    t.boolean "active", default: true
    t.boolean "banner", default: false
    t.string "image_type"
    t.integer "position"
    t.boolean "primary", default: false
    t.boolean "thumb", default: false
    t.string "url"
    t.boolean "webcomp", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "filemaker_id"
    t.string "slug"
    t.string "file_type"
    t.string "preview_url"
    t.index ["filemaker_id"], name: "index_images_on_filemaker_id"
    t.index ["item_id"], name: "index_images_on_item_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "subcategory_id"
    t.boolean "active", default: true
    t.string "circa"
    t.string "depth_in"
    t.text "description"
    t.string "description_short"
    t.string "diameter_in"
    t.string "filemaker_id"
    t.string "height_in"
    t.string "location"
    t.text "reference"
    t.boolean "sold", default: false
    t.string "width_in"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "featured", default: false
    t.string "slug"
    t.boolean "listed_category", default: true
    t.boolean "listed_designer", default: true
    t.string "depth_cm"
    t.string "diameter_cm"
    t.string "height_cm"
    t.string "width_cm"
    t.integer "size"
    t.string "designer_connector_1"
    t.string "designer_connector_2"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.index ["filemaker_id"], name: "index_items_on_filemaker_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.string "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["slug"], name: "index_pages_on_slug"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "first_name"
    t.integer "role"
    t.string "address"
    t.string "city"
    t.string "country"
    t.string "phone"
    t.string "state"
    t.string "zip"
    t.string "reference", default: [], array: true
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
