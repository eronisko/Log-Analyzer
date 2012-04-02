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

ActiveRecord::Schema.define(:version => 20120402195228) do

  create_table "ignore_lists", :force => true do |t|
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
    t.boolean  "ignored",            :default => false
    t.integer  "message_pattern_id"
    t.string   "field_1"
    t.datetime "timestamp"
    t.string   "field_2"
    t.string   "field_3"
    t.string   "field_4"
  end

  create_table "logs", :force => true do |t|
    t.integer  "investigation_id"
    t.string   "name"
    t.string   "description"
    t.string   "data_type"
    t.string   "file"
    t.integer  "time_bias"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "message_delimiter"
    t.integer  "ignore_list_id"
    t.integer  "source_id"
  end

  create_table "message_patterns", :force => true do |t|
    t.integer  "source_id"
    t.string   "name"
    t.string   "pattern"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "timestamp_definition"
    t.string   "field_1_name"
    t.string   "field_1_definition"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "field_2_name"
    t.string   "field_2_definition"
    t.string   "field_3_name"
    t.string   "field_3_definition"
    t.string   "field_4_name"
    t.string   "field_4_definition"
  end

end
