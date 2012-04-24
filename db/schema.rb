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

ActiveRecord::Schema.define(:version => 20120405204819) do

  create_table "answers", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.string   "challenge_name",      :limit => 50
    t.string   "answer_selected",     :limit => 128
    t.string   "answer_col_selected", :limit => 10
    t.string   "reason",              :limit => 500
    t.string   "correct"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "challenges", :force => true do |t|
    t.string   "name",             :limit => 50,                     :null => false
    t.text     "content",                                            :null => false
    t.string   "status",           :limit => 20,  :default => "new", :null => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "a",                :limit => 128
    t.string   "b",                :limit => 128
    t.string   "c",                :limit => 128
    t.string   "d",                :limit => 128
    t.string   "e",                :limit => 128
    t.string   "correct_col_name", :limit => 16
    t.string   "correct_answer",   :limit => 128
    t.string   "explanation",      :limit => 500
    t.integer  "user_id"
    t.string   "author",           :limit => 50
  end

  create_table "display_objects", :force => true do |t|
    t.string   "obj_type",   :limit => 30, :null => false
    t.integer  "obj_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "fun_facts", :force => true do |t|
    t.string   "name",       :limit => 50,                    :null => false
    t.text     "content",                                     :null => false
    t.string   "status",     :limit => 20, :default => "new", :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "user_id"
    t.string   "author",     :limit => 50
  end

  create_table "jokes", :force => true do |t|
    t.string   "name",       :limit => 50,                          :null => false
    t.text     "content",                                           :null => false
    t.integer  "user_id",                                           :null => false
    t.string   "author",     :limit => 50,                          :null => false
    t.string   "status",     :limit => 20, :default => "reviewing", :null => false
    t.string   "message",    :limit => 60, :default => "new"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "links", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.string   "url"
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname",              :limit => 50,                     :null => false
    t.string   "lastname",               :limit => 50,                     :null => false
    t.string   "email",                  :limit => 64,                     :null => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "privilege",                            :default => "user"
    t.string   "username",               :limit => 50,                     :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "inform_parents_token"
    t.datetime "inform_parents_sent_at"
    t.string   "parent_approved"
    t.datetime "parent_approved_at"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
