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

ActiveRecord::Schema.define(version: 20140528155058) do

  create_table "accepts", force: true do |t|
    t.integer  "basket_id"
    t.integer  "item_id"
    t.integer  "librarian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accepts", ["basket_id"], name: "index_accepts_on_basket_id"
  add_index "accepts", ["item_id"], name: "index_accepts_on_item_id"

  create_table "baskets", force: true do |t|
    t.integer  "user_id"
    t.text     "note"
    t.integer  "lock_version", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "baskets", ["user_id"], name: "index_baskets_on_user_id"

  create_table "bookstores", force: true do |t|
    t.text     "name",             null: false
    t.string   "zip_code"
    t.text     "address"
    t.text     "note"
    t.string   "telephone_number"
    t.string   "fax_number"
    t.string   "url"
    t.integer  "position"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "budget_types", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carrier_type_has_checkout_types", force: true do |t|
    t.integer  "carrier_type_id",  null: false
    t.integer  "checkout_type_id", null: false
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carrier_type_has_checkout_types", ["carrier_type_id"], name: "index_carrier_type_has_checkout_types_on_m_form_id"
  add_index "carrier_type_has_checkout_types", ["checkout_type_id"], name: "index_carrier_type_has_checkout_types_on_checkout_type_id"

  create_table "checked_items", force: true do |t|
    t.integer  "item_id",      null: false
    t.integer  "basket_id",    null: false
    t.datetime "due_date",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "librarian_id"
  end

  add_index "checked_items", ["basket_id"], name: "index_checked_items_on_basket_id"
  add_index "checked_items", ["item_id"], name: "index_checked_items_on_item_id"

  create_table "checkins", force: true do |t|
    t.integer  "item_id",                  null: false
    t.integer  "librarian_id"
    t.integer  "basket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lock_version", default: 0, null: false
  end

  add_index "checkins", ["basket_id"], name: "index_checkins_on_basket_id"
  add_index "checkins", ["item_id"], name: "index_checkins_on_item_id"
  add_index "checkins", ["librarian_id"], name: "index_checkins_on_librarian_id"

  create_table "checkout_stat_has_manifestations", force: true do |t|
    t.integer  "manifestation_checkout_stat_id", null: false
    t.integer  "manifestation_id",               null: false
    t.integer  "checkouts_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkout_stat_has_manifestations", ["manifestation_checkout_stat_id"], name: "index_checkout_stat_has_manifestations_on_checkout_stat_id"
  add_index "checkout_stat_has_manifestations", ["manifestation_id"], name: "index_checkout_stat_has_manifestations_on_manifestation_id"

  create_table "checkout_stat_has_users", force: true do |t|
    t.integer  "user_checkout_stat_id",             null: false
    t.integer  "user_id",                           null: false
    t.integer  "checkouts_count",       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkout_stat_has_users", ["user_checkout_stat_id"], name: "index_checkout_stat_has_users_on_user_checkout_stat_id"
  add_index "checkout_stat_has_users", ["user_id"], name: "index_checkout_stat_has_users_on_user_id"

  create_table "checkout_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkout_types", ["name"], name: "index_checkout_types_on_name"

  create_table "checkouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id",                            null: false
    t.integer  "checkin_id"
    t.integer  "librarian_id"
    t.integer  "basket_id"
    t.datetime "due_date"
    t.integer  "checkout_renewal_count", default: 0, null: false
    t.integer  "lock_version",           default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkouts", ["basket_id"], name: "index_checkouts_on_basket_id"
  add_index "checkouts", ["checkin_id"], name: "index_checkouts_on_checkin_id"
  add_index "checkouts", ["item_id", "basket_id"], name: "index_checkouts_on_item_id_and_basket_id", unique: true
  add_index "checkouts", ["item_id"], name: "index_checkouts_on_item_id"
  add_index "checkouts", ["librarian_id"], name: "index_checkouts_on_librarian_id"
  add_index "checkouts", ["user_id"], name: "index_checkouts_on_user_id"

  create_table "circulation_statuses", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_has_use_restrictions", force: true do |t|
    t.integer  "item_id",            null: false
    t.integer  "use_restriction_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_has_use_restrictions", ["item_id"], name: "index_item_has_use_restrictions_on_item_id"
  add_index "item_has_use_restrictions", ["use_restriction_id"], name: "index_item_has_use_restrictions_on_use_restriction_id"

  create_table "items", force: true do |t|
    t.string   "call_number"
    t.string   "item_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "shelf_id",                    default: 1,     null: false
    t.integer  "basket_id"
    t.boolean  "include_supplements",         default: false, null: false
    t.integer  "checkouts_count",             default: 0,     null: false
    t.integer  "owns_count",                  default: 0,     null: false
    t.integer  "resource_has_subjects_count", default: 0,     null: false
    t.text     "note"
    t.string   "url"
    t.integer  "price"
    t.integer  "lock_version",                default: 0,     null: false
    t.integer  "required_role_id",            default: 1,     null: false
    t.string   "state"
    t.integer  "required_score",              default: 0,     null: false
    t.integer  "circulation_status_id",       default: 5,     null: false
    t.integer  "checkout_type_id",            default: 1,     null: false
  end

  add_index "items", ["checkout_type_id"], name: "index_items_on_checkout_type_id"
  add_index "items", ["circulation_status_id"], name: "index_items_on_circulation_status_id"
  add_index "items", ["item_identifier"], name: "index_items_on_item_identifier"
  add_index "items", ["required_role_id"], name: "index_items_on_required_role_id"
  add_index "items", ["shelf_id"], name: "index_items_on_shelf_id"

  create_table "lending_policies", force: true do |t|
    t.integer  "item_id",                    null: false
    t.integer  "user_group_id",              null: false
    t.integer  "loan_period",    default: 0, null: false
    t.datetime "fixed_due_date"
    t.integer  "renewal",        default: 0, null: false
    t.integer  "fine",           default: 0, null: false
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lending_policies", ["item_id", "user_group_id"], name: "index_lending_policies_on_item_id_and_user_group_id", unique: true

  create_table "libraries", force: true do |t|
    t.string   "name",                                null: false
    t.text     "display_name"
    t.string   "short_display_name",                  null: false
    t.string   "zip_code"
    t.text     "street"
    t.text     "locality"
    t.text     "region"
    t.string   "telephone_number_1"
    t.string   "telephone_number_2"
    t.string   "fax_number"
    t.text     "note"
    t.integer  "call_number_rows",      default: 1,   null: false
    t.string   "call_number_delimiter", default: "|", null: false
    t.integer  "library_group_id",      default: 1,   null: false
    t.integer  "users_count",           default: 0,   null: false
    t.integer  "position"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.text     "opening_hour"
    t.string   "isil"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "libraries", ["library_group_id"], name: "index_libraries_on_library_group_id"
  add_index "libraries", ["name"], name: "index_libraries_on_name", unique: true

  create_table "library_groups", force: true do |t|
    t.string   "name",                                              null: false
    t.text     "display_name"
    t.string   "short_name",                                        null: false
    t.string   "email"
    t.text     "my_networks"
    t.text     "login_banner"
    t.text     "note"
    t.integer  "country_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "admin_networks"
    t.string   "url",            default: "http://localhost:3000/"
  end

  add_index "library_groups", ["short_name"], name: "index_library_groups_on_short_name"

  create_table "manifestation_checkout_stats", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "note"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "completed_at"
  end

  add_index "manifestation_checkout_stats", ["state"], name: "index_manifestation_checkout_stats_on_state"

  create_table "manifestation_reserve_stats", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "note"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "completed_at"
  end

  add_index "manifestation_reserve_stats", ["state"], name: "index_manifestation_reserve_stats_on_state"

  create_table "order_list_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",      default: "{}"
    t.integer  "sort_key"
    t.integer  "order_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_list_transitions", ["order_list_id"], name: "index_order_list_transitions_on_order_list_id"
  add_index "order_list_transitions", ["sort_key", "order_list_id"], name: "index_order_list_transitions_on_sort_key_and_order_list_id", unique: true

  create_table "order_lists", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "bookstore_id", null: false
    t.text     "title",        null: false
    t.text     "note"
    t.datetime "ordered_at"
    t.datetime "deleted_at"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_lists", ["bookstore_id"], name: "index_order_lists_on_bookstore_id"
  add_index "order_lists", ["user_id"], name: "index_order_lists_on_user_id"

  create_table "orders", force: true do |t|
    t.integer  "order_list_id",       null: false
    t.integer  "purchase_request_id", null: false
    t.integer  "position"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["order_list_id"], name: "index_orders_on_order_list_id"
  add_index "orders", ["purchase_request_id"], name: "index_orders_on_purchase_request_id"

  create_table "purchase_requests", force: true do |t|
    t.integer  "user_id",             null: false
    t.text     "title",               null: false
    t.text     "author"
    t.text     "publisher"
    t.string   "isbn"
    t.datetime "date_of_publication"
    t.integer  "price"
    t.string   "url"
    t.text     "note"
    t.datetime "accepted_at"
    t.datetime "denied_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "state"
    t.string   "pub_date"
  end

  add_index "purchase_requests", ["state"], name: "index_purchase_requests_on_state"
  add_index "purchase_requests", ["user_id"], name: "index_purchase_requests_on_user_id"

  create_table "request_status_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "request_types", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reserve_stat_has_manifestations", force: true do |t|
    t.integer  "manifestation_reserve_stat_id", null: false
    t.integer  "manifestation_id",              null: false
    t.integer  "reserves_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reserve_stat_has_manifestations", ["manifestation_id"], name: "index_reserve_stat_has_manifestations_on_manifestation_id"
  add_index "reserve_stat_has_manifestations", ["manifestation_reserve_stat_id"], name: "index_reserve_stat_has_manifestations_on_m_reserve_stat_id"

  create_table "reserve_stat_has_users", force: true do |t|
    t.integer  "user_reserve_stat_id", null: false
    t.integer  "user_id",              null: false
    t.integer  "reserves_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reserve_stat_has_users", ["user_id"], name: "index_reserve_stat_has_users_on_user_id"
  add_index "reserve_stat_has_users", ["user_reserve_stat_id"], name: "index_reserve_stat_has_users_on_user_reserve_stat_id"

  create_table "reserves", force: true do |t|
    t.integer  "user_id",                                      null: false
    t.integer  "manifestation_id",                             null: false
    t.integer  "item_id"
    t.integer  "request_status_type_id",                       null: false
    t.datetime "checked_out_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "canceled_at"
    t.datetime "expired_at"
    t.datetime "deleted_at"
    t.string   "state"
    t.boolean  "expiration_notice_to_patron",  default: false
    t.boolean  "expiration_notice_to_library", default: false
    t.datetime "retained_at"
    t.datetime "postponed_at"
    t.integer  "lock_version",                 default: 0,     null: false
  end

  add_index "reserves", ["item_id"], name: "index_reserves_on_item_id"
  add_index "reserves", ["manifestation_id"], name: "index_reserves_on_manifestation_id"
  add_index "reserves", ["request_status_type_id"], name: "index_reserves_on_request_status_type_id"
  add_index "reserves", ["state"], name: "index_reserves_on_state"
  add_index "reserves", ["user_id"], name: "index_reserves_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_engines", force: true do |t|
    t.string   "name",             null: false
    t.text     "display_name"
    t.string   "url",              null: false
    t.text     "base_url",         null: false
    t.text     "http_method",      null: false
    t.text     "query_param",      null: false
    t.text     "additional_param"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shelves", force: true do |t|
    t.string   "name",                         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "library_id",   default: 1,     null: false
    t.integer  "items_count",  default: 0,     null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean  "closed",       default: false, null: false
  end

  add_index "shelves", ["library_id"], name: "index_shelves_on_library_id"

  create_table "subscribes", force: true do |t|
    t.integer  "subscription_id", null: false
    t.integer  "work_id",         null: false
    t.datetime "start_at",        null: false
    t.datetime "end_at",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscribes", ["subscription_id"], name: "index_subscribes_on_subscription_id"
  add_index "subscribes", ["work_id"], name: "index_subscribes_on_work_id"

  create_table "subscriptions", force: true do |t|
    t.text     "title",                        null: false
    t.text     "note"
    t.integer  "user_id"
    t.integer  "order_list_id"
    t.datetime "deleted_at"
    t.integer  "subscribes_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["order_list_id"], name: "index_subscriptions_on_order_list_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "use_restrictions", force: true do |t|
    t.string   "name",         null: false
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_checkout_stats", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "note"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "completed_at"
  end

  add_index "user_checkout_stats", ["state"], name: "index_user_checkout_stats_on_state"

  create_table "user_group_has_checkout_types", force: true do |t|
    t.integer  "user_group_id",                                   null: false
    t.integer  "checkout_type_id",                                null: false
    t.integer  "checkout_limit",                  default: 0,     null: false
    t.integer  "checkout_period",                 default: 0,     null: false
    t.integer  "checkout_renewal_limit",          default: 0,     null: false
    t.integer  "reservation_limit",               default: 0,     null: false
    t.integer  "reservation_expired_period",      default: 7,     null: false
    t.boolean  "set_due_date_before_closing_day", default: false, null: false
    t.datetime "fixed_due_date"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_checkout_count"
  end

  add_index "user_group_has_checkout_types", ["checkout_type_id"], name: "index_user_group_has_checkout_types_on_checkout_type_id"
  add_index "user_group_has_checkout_types", ["user_group_id"], name: "index_user_group_has_checkout_types_on_user_group_id"

  create_table "user_groups", force: true do |t|
    t.string   "name"
    t.text     "display_name"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "valid_period_for_new_user",        default: 0, null: false
    t.datetime "expired_at"
    t.integer  "number_of_day_to_notify_overdue",  default: 1, null: false
    t.integer  "number_of_day_to_notify_due_date", default: 7, null: false
    t.integer  "number_of_time_to_notify_overdue", default: 3, null: false
  end

  create_table "user_has_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_reserve_stats", force: true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "note"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "started_at"
    t.datetime "completed_at"
  end

  add_index "user_reserve_stats", ["state"], name: "index_user_reserve_stats_on_state"

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                    default: "",    null: false
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.boolean  "save_checkout_history",    default: false, null: false
    t.string   "checkout_icalendar_token"
    t.string   "username"
    t.string   "user_number"
    t.string   "state"
    t.string   "locale"
    t.datetime "deleted_at"
    t.datetime "expired_at"
    t.integer  "library_id",               default: 1,     null: false
    t.integer  "required_role_id",         default: 1,     null: false
    t.integer  "user_group_id",            default: 1,     null: false
    t.text     "note"
    t.text     "keyword_list"
    t.integer  "failed_attempts"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "confirmed_at"
  end

  add_index "users", ["checkout_icalendar_token"], name: "index_users_on_checkout_icalendar_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  add_index "users", ["user_group_id"], name: "index_users_on_user_group_id"
  add_index "users", ["user_number"], name: "index_users_on_user_number", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
