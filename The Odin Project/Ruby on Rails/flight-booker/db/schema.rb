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

ActiveRecord::Schema.define(version: 20140624164919) do

  create_table "airports", force: true do |t|
    t.string   "code"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", force: true do |t|
    t.integer  "flight_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["flight_id"], name: "index_bookings_on_flight_id"

  create_table "flights", force: true do |t|
    t.integer  "from_airport_id"
    t.integer  "to_airport_id"
    t.datetime "date"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flights", ["from_airport_id"], name: "index_flights_on_from_airport_id"

  create_table "passengers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.integer  "booking_id"
    t.integer  "passenger_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["booking_id"], name: "index_tickets_on_booking_id"
  add_index "tickets", ["passenger_id"], name: "index_tickets_on_passenger_id"

end
