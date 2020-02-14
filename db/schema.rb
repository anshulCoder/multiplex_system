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

ActiveRecord::Schema.define(version: 2020_02_07_095332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_bookings", id: :serial, force: :cascade do |t|
    t.string "booking_status"
    t.text "seat_ids", default: [], array: true
    t.integer "user_id"
    t.integer "show_timing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["show_timing_id"], name: "index_movie_bookings_on_show_timing_id"
    t.index ["user_id"], name: "index_movie_bookings_on_user_id"
  end

  create_table "movies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "rating"
    t.text "description"
    t.datetime "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "multiplexes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "references", id: :serial, force: :cascade do |t|
    t.integer "referred_id"
    t.integer "referral_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "screens", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "screen_type"
    t.integer "seats_capacity"
    t.integer "multiplex_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["multiplex_id"], name: "index_screens_on_multiplex_id"
    t.index ["name"], name: "index_screens_on_name"
  end

  create_table "seats", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "seat_type"
    t.float "cost"
    t.boolean "is_available", default: true
    t.integer "screen_id"
    t.integer "movie_booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_booking_id"], name: "index_seats_on_movie_booking_id"
    t.index ["screen_id"], name: "index_seats_on_screen_id"
  end

  create_table "show_timings", id: :serial, force: :cascade do |t|
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.integer "movie_id"
    t.integer "screen_id"
    t.integer "multiplex_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_show_timings_on_movie_id"
    t.index ["multiplex_id"], name: "index_show_timings_on_multiplex_id"
    t.index ["screen_id"], name: "index_show_timings_on_screen_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "phone_number"
    t.float "reward_points"
    t.string "user_tier"
    t.string "referral_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
