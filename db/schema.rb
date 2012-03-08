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

ActiveRecord::Schema.define(:version => 20120302170915) do

  create_table "elimination_lists", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "pattern_list"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "investigations", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "log_messages", :force => true do |t|
    t.integer  "log_id"
    t.string   "raw_message"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "ignored",     :default => false
  end

  create_table "logs", :force => true do |t|
    t.integer  "investigation_id"
    t.string   "name"
    t.string   "description"
    t.string   "data_type"
    t.string   "file"
    t.integer  "time_bias"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
