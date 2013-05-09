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

ActiveRecord::Schema.define(:version => 20130508224212) do

  create_table "api_keys", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "access_key"
  end

  create_table "jobs", :force => true do |t|
    t.datetime "starttime"
    t.datetime "endtime"
    t.string   "status"
    t.string   "email"
    t.string   "platform"
    t.string   "language"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "papertrail_system"
    t.string   "job_id"
    t.string   "user_id"
    t.string   "code_url"
  end

  create_table "logger_accounts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "papertrail_id"
    t.string   "papertrail_api_token"
  end

  create_table "logger_systems", :force => true do |t|
    t.string   "name"
    t.string   "papertrail_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "logger_account_id"
    t.string   "papertrail_account_id"
    t.string   "syslog_hostname"
    t.string   "syslog_port"
  end

  create_table "servers", :force => true do |t|
    t.string   "name"
    t.string   "installed_services"
    t.string   "instance_url"
    t.string   "operating_system"
    t.string   "password"
    t.string   "platform"
    t.string   "repo_name"
    t.string   "status"
    t.string   "languages"
    t.string   "username"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "job_id"
  end

end
