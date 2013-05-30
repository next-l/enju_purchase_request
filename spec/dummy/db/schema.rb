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

ActiveRecord::Schema.define(:version => 20111201163718) do

  create_table "bookstores", :force => true do |t|
    t.text     "name",             :null => false
    t.string   "zip_code"
    t.text     "address"
    t.text     "note"
    t.string   "telephone_number"
    t.string   "fax_number"
    t.string   "url"
    t.integer  "position"
    t.datetime "deleted_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "call_number"
    t.string   "item_identifier"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.datetime "deleted_at"
    t.integer  "shelf_id",                    :default => 1,     :null => false
    t.integer  "basket_id"
    t.boolean  "include_supplements",         :default => false, :null => false
    t.integer  "checkouts_count",             :default => 0,     :null => false
    t.integer  "owns_count",                  :default => 0,     :null => false
    t.integer  "resource_has_subjects_count", :default => 0,     :null => false
    t.text     "note"
    t.string   "url"
    t.integer  "price"
    t.integer  "lock_version",                :default => 0,     :null => false
    t.integer  "required_role_id",            :default => 1,     :null => false
    t.string   "state"
    t.integer  "required_score",              :default => 0,     :null => false
  end

  add_index "items", ["item_identifier"], :name => "index_items_on_item_identifier"
  add_index "items", ["required_role_id"], :name => "index_items_on_required_role_id"
  add_index "items", ["shelf_id"], :name => "index_items_on_shelf_id"

  create_table "library_groups", :force => true do |t|
    t.string   "name",                                                 :null => false
    t.text     "display_name"
    t.string   "short_name",                                           :null => false
    t.string   "email"
    t.text     "my_networks"
    t.text     "login_banner"
    t.text     "note"
    t.integer  "country_id"
    t.integer  "position"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.text     "admin_networks"
    t.string   "url",            :default => "http://localhost:3000/"
  end

  add_index "library_groups", ["short_name"], :name => "index_library_groups_on_short_name"

  create_table "order_lists", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "bookstore_id", :null => false
    t.text     "title",        :null => false
    t.text     "note"
    t.datetime "ordered_at"
    t.datetime "deleted_at"
    t.string   "state"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "order_lists", ["bookstore_id"], :name => "index_order_lists_on_bookstore_id"
  add_index "order_lists", ["user_id"], :name => "index_order_lists_on_user_id"

  create_table "orders", :force => true do |t|
    t.integer  "order_list_id",       :null => false
    t.integer  "purchase_request_id", :null => false
    t.integer  "position"
    t.string   "state"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "orders", ["order_list_id"], :name => "index_orders_on_order_list_id"
  add_index "orders", ["purchase_request_id"], :name => "index_orders_on_purchase_request_id"

  create_table "purchase_requests", :force => true do |t|
    t.integer  "user_id",             :null => false
    t.text     "title",               :null => false
    t.text     "author"
    t.text     "publisher"
    t.string   "isbn"
    t.datetime "date_of_publication"
    t.integer  "price"
    t.string   "url"
    t.text     "note"
    t.datetime "accepted_at"
    t.datetime "denied_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.datetime "deleted_at"
    t.string   "state"
    t.string   "pub_date"
  end

  add_index "purchase_requests", ["state"], :name => "index_purchase_requests_on_state"
  add_index "purchase_requests", ["user_id"], :name => "index_purchase_requests_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_has_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "user_group_id"
    t.integer  "required_role_id"
    t.string   "username"
    t.text     "note"
    t.string   "locale"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
