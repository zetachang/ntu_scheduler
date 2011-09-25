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

ActiveRecord::Schema.define(:version => 20110925032417) do

  create_table "days", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "location"
    t.integer  "time",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_sets", :force => true do |t|
    t.integer  "permalink_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedule_sets", ["permalink_id"], :name => "index_schedule_sets_on_permalink_id", :unique => true

  create_table "schedules", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                  :null => false
    t.string   "student_id",                :null => false
    t.integer  "facebook_uid", :limit => 8, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facebook_uid"], :name => "index_users_on_facebook_uid", :unique => true

end
