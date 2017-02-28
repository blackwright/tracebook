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

ActiveRecord::Schema.define(version: 20170217193204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.string   "commentable_type", null: false
    t.integer  "commentable_id",   null: false
    t.text     "body",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "friendings", force: :cascade do |t|
    t.integer  "friender_id",                 null: false
    t.integer  "friended_id",                 null: false
    t.boolean  "accepted",    default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["friended_id"], name: "index_friendings_on_friended_id", using: :btree
    t.index ["friender_id"], name: "index_friendings_on_friender_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id",            null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["user_id"], name: "index_photos_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.date     "birthday"
    t.string   "gender"
    t.string   "college"
    t.string   "hometown"
    t.string   "location"
    t.string   "phone"
    t.text     "tagline"
    t.text     "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "avatar_id"
    t.integer  "cover_id"
    t.index ["avatar_id"], name: "index_profiles_on_avatar_id", using: :btree
    t.index ["cover_id"], name: "index_profiles_on_cover_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "auth_token",      null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email", "auth_token"], name: "index_users_on_email_and_auth_token", unique: true, using: :btree
  end

  add_foreign_key "comments", "users"
  add_foreign_key "friendings", "users", column: "friended_id"
  add_foreign_key "friendings", "users", column: "friender_id"
  add_foreign_key "likes", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "photos", column: "avatar_id"
  add_foreign_key "profiles", "photos", column: "cover_id"
  add_foreign_key "profiles", "users"
end
