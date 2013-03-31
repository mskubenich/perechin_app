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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130331174940) do

  create_table "actions", :force => true do |t|
    t.string "controller"
    t.string "action"
    t.string "method"
  end

  create_table "anecdotes", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "art_categories", :force => true do |t|
    t.string "title"
  end

  create_table "art_subcategories", :force => true do |t|
    t.string  "title"
    t.integer "art_category_id"
    t.boolean "is_moderated"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body",       :limit => 16777215
    t.integer  "user_id"
    t.string   "source"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "view_count"
  end

  create_table "articles_tags", :force => true do |t|
    t.integer "article_id"
    t.integer "tag_id"
  end

  create_table "attached_assets", :force => true do |t|
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "news_id"
    t.integer  "article_id"
    t.integer  "work_id"
    t.integer  "anecdote_id"
    t.integer  "populated_place_id"
  end

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "news_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "article_id"
    t.integer  "work_id"
  end

  create_table "controller_role_permissions", :force => true do |t|
    t.integer "role_id"
    t.integer "action_id"
    t.boolean "has_access"
  end

  create_table "join_confirmations", :force => true do |t|
    t.integer  "user_id"
    t.string   "activation_code"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "body",       :limit => 16777215
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "user_id"
    t.string   "source"
    t.integer  "view_count"
  end

  create_table "news_tags", :force => true do |t|
    t.integer "news_id"
    t.integer "tag_id"
  end

  create_table "populated_places", :force => true do |t|
    t.string "title"
    t.text   "description"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "showplaces", :force => true do |t|
    t.string  "name"
    t.float   "latitude"
    t.float   "longitude"
    t.boolean "gmaps"
  end

  create_table "tags", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "role_id"
    t.integer  "article_id"
    t.text     "about_me"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "works", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "art_subcategory_id"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "moderate"
    t.integer  "view_count"
  end

end
