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

ActiveRecord::Schema.define(:version => 20110429023832) do

  create_table "rides", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "strava_ride_id"
    t.float    "normalized_power",      :default => 0.0
    t.float    "training_stress_score", :default => 0.0
    t.float    "intensity_factor",      :default => 0.0
    t.integer  "user_id"
    t.boolean  "synced",                :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "strava_athlete_id"
    t.string   "strava_api_token"
    t.integer  "threshold_power"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
