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

ActiveRecord::Schema.define(version: 2019_02_16_153206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_instances", force: :cascade do |t|
    t.string "class_id"
    t.string "timestamp"
    t.string "professor"
    t.string "date_semester"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_instances_on_course_id"
  end

  create_table "course_instances_graduations", id: false, force: :cascade do |t|
    t.bigint "course_instance_id"
    t.bigint "graduation_id"
    t.index ["course_instance_id"], name: "index_course_instances_graduations_on_course_instance_id"
    t.index ["graduation_id"], name: "index_course_instances_graduations_on_graduation_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "course_type"
    t.string "category"
    t.integer "semester"
    t.bigint "workload_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workload_id"], name: "index_courses_on_workload_id"
  end

  create_table "graduations", force: :cascade do |t|
    t.string "gradu_id"
    t.string "code"
    t.string "name"
    t.string "faculty"
    t.string "minch"
    t.string "maxch"
    t.integer "semesters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timeslots", force: :cascade do |t|
    t.integer "day"
    t.integer "starting_hour"
    t.integer "ending_hour"
    t.bigint "course_instance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_instance_id"], name: "index_timeslots_on_course_instance_id"
  end

  create_table "workloads", force: :cascade do |t|
    t.integer "classroom"
    t.integer "lab"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "courses", "workloads"
end
