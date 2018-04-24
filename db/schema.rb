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

ActiveRecord::Schema.define(version: 20180407152215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "geo_data_points", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "geo_segment_id"
    t.datetime "occurred_at"
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :has_z=>true, :geographic=>true}
    t.string "device_id"
    t.integer "speed"
    t.integer "horizontal_accuracy"
    t.integer "vertical_accuracy"
    t.integer "motion"
    t.integer "battery_state"
    t.integer "battery_level"
    t.string "wifi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geo_segment_id"], name: "index_geo_data_points_on_geo_segment_id"
    t.index ["location"], name: "index_geo_data_points_on_location", using: :gist
    t.index ["user_id"], name: "index_geo_data_points_on_user_id"
  end

  create_table "geo_places", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "foursquareId"
    t.string "foursquareCategoryIds", array: true
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location"], name: "index_geo_places_on_location", using: :gist
    t.index ["user_id"], name: "index_geo_places_on_user_id"
  end

  create_table "geo_segments", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "type"
    t.integer "activity_detected"
    t.integer "activity_selected"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer "duration"
    t.integer "steps"
    t.integer "calories"
    t.integer "distance"
    t.integer "battery_usage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ended_at"], name: "index_geo_segments_on_ended_at"
    t.index ["started_at"], name: "index_geo_segments_on_started_at"
    t.index ["user_id"], name: "index_geo_segments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
