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

ActiveRecord::Schema.define(version: 20150224025715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exclusives", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.string   "twitter"
    t.string   "linkedin"
    t.integer  "budget"
    t.text     "description"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "faqs", force: true do |t|
    t.string   "category"
    t.string   "question"
    t.text     "answer"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "anchor"
  end

  create_table "leads", force: true do |t|
    t.string   "photo"
    t.string   "title"
    t.string   "url"
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "budget"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "prospects", force: true do |t|
    t.string   "name"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rfps", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "workers", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
