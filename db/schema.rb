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

ActiveRecord::Schema.define(version: 20210404151720) do

  create_table "campaigns", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.boolean  "subscription"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "image"
    t.integer  "goal"
    t.integer  "raised"
    t.boolean  "active",       default: true
  end

  create_table "charges", force: :cascade do |t|
    t.string   "charge_id"
    t.integer  "amount"
    t.integer  "amount_refunded"
    t.integer  "campaign_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
  end

  create_table "disbursments", force: :cascade do |t|
    t.integer  "payment_sheet_id"
    t.string   "driver_name"
    t.string   "driver_phone"
    t.integer  "amount"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "commissions"
    t.integer  "tips"
    t.integer  "charges"
    t.integer  "credits"
    t.integer  "deliveries_made"
    t.boolean  "not_found"
    t.index ["payment_sheet_id"], name: "index_disbursments_on_payment_sheet_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "payment_sheets", force: :cascade do |t|
    t.string   "sheet"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "number_of_drivers"
    t.integer  "total_paid"
    t.boolean  "finished",          default: false
    t.integer  "not_found"
    t.boolean  "failed"
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "deliveries"
    t.integer  "days_worked"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_stats_on_user_id"
  end

  create_table "stripe_accounts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "account_type"
    t.integer  "dob_month"
    t.integer  "dob_day"
    t.integer  "dob_year"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_line1"
    t.string   "address_postal"
    t.boolean  "tos"
    t.string   "ssn_last_4"
    t.string   "business_name"
    t.string   "business_tax_id"
    t.string   "personal_id_number"
    t.string   "verification_document"
    t.string   "acct_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           default: "",    null: false
    t.string   "encrypted_password",              default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "stripe_account"
    t.boolean  "admin",                           default: false
    t.string   "phone_number"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "payout_wait"
    t.boolean  "is_active"
    t.string   "candidate_id"
    t.integer  "failed_attempts",                 default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "drivers_license"
    t.string   "insurance_card"
    t.boolean  "bgc_paid"
    t.integer  "referred_by_id"
    t.boolean  "refer_paid"
    t.integer  "location_id"
    t.date     "drivers_license_expiration_date"
    t.date     "insurance_card_expiration_date"
    t.boolean  "inactive",                        default: false
    t.date     "bgc_completed"
    t.boolean  "accept_sms",                      default: true
    t.string   "discovered"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["referred_by_id"], name: "index_users_on_referred_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
