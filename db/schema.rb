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

ActiveRecord::Schema.define(version: 20180726032452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.string "stripe_customer_id"
    t.integer "plan_id"
    t.string "stripe_subscription_id"
    t.string "stripe_subscription_status"
    t.string "slug"
    t.boolean "is_basic", default: true
    t.index ["plan_id"], name: "index_accounts_on_plan_id"
  end

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "boards", id: :serial, force: :cascade do |t|
    t.text "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "title"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "challenges", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.integer "user_id"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "consents", force: :cascade do |t|
    t.string "name"
    t.boolean "mandatory"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "detail_items", id: :serial, force: :cascade do |t|
    t.integer "detail_id"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "value"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.index ["item_id"], name: "index_details_on_item_id"
  end

  create_table "invitations", id: :serial, force: :cascade do |t|
    t.string "email"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.integer "project_id"
    t.index ["account_id"], name: "index_invitations_on_account_id"
    t.index ["token"], name: "index_invitations_on_token"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "slug"
    t.boolean "image_processing"
    t.string "link"
    t.integer "user_id"
    t.boolean "is_private", default: true
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_memberships_on_account_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", id: :serial, force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.integer "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_data"
    t.integer "board_id"
    t.integer "item_id"
    t.integer "challenge_id"
  end

  create_table "plans", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.string "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "projects_allowed"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
    t.integer "account_id"
    t.integer "user_id"
    t.boolean "is_public"
    t.string "slug"
    t.boolean "displayed"
    t.index ["author_id"], name: "index_projects_on_author_id"
  end

  create_table "responds", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "board_id"
    t.integer "challenge_id"
    t.integer "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", id: :serial, force: :cascade do |t|
    t.text "description"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "detail_id"
    t.integer "user_id"
    t.integer "item_id"
    t.text "properties"
  end

  create_table "subscription_events", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.string "type"
    t.jsonb "data"
    t.datetime "created_at"
    t.index ["account_id"], name: "index_subscription_events_on_account_id"
  end

  create_table "user_consents", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "consent_id"
    t.boolean "agreed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consent_id"], name: "index_user_consents_on_consent_id"
    t.index ["user_id"], name: "index_user_consents_on_user_id"
  end

  create_table "user_projects", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.integer "project_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "plans"
  add_foreign_key "boards", "users"
  add_foreign_key "details", "items"
  add_foreign_key "invitations", "accounts"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "memberships", "users"
  add_foreign_key "projects", "users", column: "author_id"
  add_foreign_key "subscription_events", "accounts"
  add_foreign_key "user_consents", "consents"
  add_foreign_key "user_consents", "users"
end
