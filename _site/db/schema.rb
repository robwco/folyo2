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

ActiveRecord::Schema.define(version: 20170212223935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "site_owner"
    t.boolean  "leads_only"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "announcements", force: true do |t|
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "approved_links", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.text     "description"
    t.datetime "pub_date"
    t.string   "guid"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "categories_projects", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "project_id"
  end

  add_index "categories_projects", ["category_id", "project_id"], name: "index_categories_projects_on_category_id_and_project_id", using: :btree
  add_index "categories_projects", ["project_id"], name: "index_categories_projects_on_project_id", using: :btree

  create_table "categories_users", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "user_id"
  end

  add_index "categories_users", ["category_id"], name: "index_categories_users_on_category_id", using: :btree
  add_index "categories_users", ["user_id"], name: "index_categories_users_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

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
    t.string   "ancestry"
    t.string   "title"
  end

  add_index "faqs", ["ancestry"], name: "index_faqs_on_ancestry", using: :btree

  create_table "favorite_leads", force: true do |t|
    t.integer  "lead_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "imported_plans", force: true do |t|
    t.integer  "memberful_id"
    t.string   "name"
    t.string   "slug"
    t.string   "renewal_period"
    t.string   "interval_unit"
    t.integer  "interval_count"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
  end

  add_index "imported_plans", ["plan_id"], name: "index_imported_plans_on_plan_id", using: :btree

  create_table "imported_subscriptions", force: true do |t|
    t.integer  "memberful_id"
    t.string   "name"
    t.string   "email"
    t.integer  "memberful_plan_id"
    t.boolean  "renews"
    t.string   "stripe_customer_id"
    t.datetime "subscription_start"
    t.datetime "subscription_end"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "imported_subscriptions", ["user_id"], name: "index_imported_subscriptions_on_user_id", using: :btree

  create_table "job_sources", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "category_id"
    t.text     "description"
    t.integer  "job_source_id"
  end

  add_index "leads", ["job_source_id"], name: "index_leads_on_job_source_id", using: :btree

  create_table "listing_packages", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.boolean  "unlimited_portfolio_replies", default: false
    t.boolean  "send_to_twitter",             default: false
    t.boolean  "send_to_email_list",          default: false
    t.boolean  "done_for_you",                default: false
  end

  create_table "messages", force: true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "reply_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "to_user_id"
    t.boolean  "message_read", default: false
    t.boolean  "archived",     default: false
  end

  add_index "messages", ["project_id"], name: "index_messages_on_project_id", using: :btree
  add_index "messages", ["reply_id"], name: "index_messages_on_reply_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "milestones", force: true do |t|
    t.text "description"
  end

  create_table "milestones_users", id: false, force: true do |t|
    t.integer "milestone_id"
    t.integer "user_id"
  end

  add_index "milestones_users", ["milestone_id"], name: "index_milestones_users_on_milestone_id", using: :btree
  add_index "milestones_users", ["user_id"], name: "index_milestones_users_on_user_id", using: :btree

  create_table "offerings", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "title"
    t.text     "description"
    t.string   "contact_info"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "plans", force: true do |t|
    t.string   "stripe_id"
    t.string   "name"
    t.text     "description"
    t.integer  "amount"
    t.string   "interval"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trial_period_days"
    t.integer  "interval_count"
    t.string   "offer_description"
    t.boolean  "portfolio_replies", default: false
    t.boolean  "leads",             default: false
    t.boolean  "unlimited_replies", default: false
    t.boolean  "view_reply_count",  default: false
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.integer  "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "project_sales", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "listing_package_id"
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_sales", ["listing_package_id"], name: "index_project_sales_on_listing_package_id", using: :btree
  add_index "project_sales", ["project_id"], name: "index_project_sales_on_project_id", using: :btree
  add_index "project_sales", ["user_id"], name: "index_project_sales_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "goals"
    t.string   "budget"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_logo_file_name"
    t.string   "company_logo_content_type"
    t.integer  "company_logo_file_size"
    t.datetime "company_logo_updated_at"
    t.integer  "listing_package_id"
    t.integer  "user_id"
    t.boolean  "published"
    t.text     "long_description"
    t.text     "long_description_html"
    t.boolean  "archived",                  default: false
    t.string   "status"
    t.integer  "priority",                  default: 0
    t.datetime "priority_start"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "prospects", force: true do |t|
    t.string   "name"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommended_freelancers", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.integer  "price"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "replies", force: true do |t|
    t.string   "message",                      limit: 300
    t.integer  "user_id"
    t.string   "portfolio_message",            limit: 600
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",                                default: false
    t.string   "portfolio_image_file_name"
    t.string   "portfolio_image_content_type"
    t.integer  "portfolio_image_file_size"
    t.datetime "portfolio_image_updated_at"
    t.datetime "published_at"
    t.string   "biography",                    limit: 300
    t.string   "next_steps",                   limit: 300
    t.boolean  "message_read",                             default: false
    t.boolean  "archived",                                 default: false
    t.boolean  "has_portfolio",                            default: false
  end

  add_index "replies", ["project_id"], name: "index_replies_on_project_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

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

  create_table "rss_feeds", force: true do |t|
    t.string   "name"
    t.string   "xml_url"
    t.datetime "last_updated"
  end

  create_table "rss_links", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.text     "description"
    t.datetime "pub_date"
    t.string   "guid"
    t.integer  "rss_feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden"
    t.boolean  "approved"
  end

  add_index "rss_links", ["guid"], name: "index_rss_links_on_guid", using: :btree
  add_index "rss_links", ["rss_feed_id"], name: "index_rss_links_on_rss_feed_id", using: :btree

  create_table "sales", force: true do |t|
    t.string   "email"
    t.string   "guid"
    t.integer  "product_id"
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales", ["product_id"], name: "index_sales_on_product_id", using: :btree

  create_table "stripe_webhooks", force: true do |t|
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.string   "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coupon_code"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                 default: "", null: false
    t.string   "encrypted_password",                    default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "stripe_customer_id"
    t.string   "state"
    t.boolean  "canceling"
    t.string   "last4"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "project_alerts"
    t.string   "account_type"
    t.string   "biography",                 limit: 300
    t.string   "location"
    t.string   "company_name"
    t.string   "company_website"
    t.string   "company_biography",         limit: 500
    t.string   "company_logo_file_name"
    t.string   "company_logo_content_type"
    t.integer  "company_logo_file_size"
    t.datetime "company_logo_updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "workers", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
