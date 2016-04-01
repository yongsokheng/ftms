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

ActiveRecord::Schema.define(version: 20160405092217) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "course_subjects", force: :cascade do |t|
    t.integer  "position",            limit: 4,     default: 0
    t.string   "subject_name",        limit: 255
    t.text     "subject_description", limit: 65535
    t.text     "subject_content",     limit: 65535
    t.integer  "subject_id",          limit: 4
    t.integer  "course_id",           limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "course_subjects", ["course_id"], name: "index_course_subjects_on_course_id", using: :btree
  add_index "course_subjects", ["subject_id"], name: "index_course_subjects_on_subject_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "avatar",      limit: 255
    t.text     "description", limit: 65535
    t.text     "content",     limit: 65535
    t.integer  "status",      limit: 4,     default: 0
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "evaluation_details", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "point",                  limit: 4
    t.integer  "evaluation_id",          limit: 4
    t.integer  "evaluation_template_id", limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "evaluation_details", ["evaluation_id"], name: "index_evaluation_details_on_evaluation_id", using: :btree
  add_index "evaluation_details", ["evaluation_template_id"], name: "index_evaluation_details_on_evaluation_template_id", using: :btree

  create_table "evaluation_templates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "min_point",  limit: 4
    t.integer  "max_point",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.string   "assessment",   limit: 255
    t.integer  "total_point",  limit: 4
    t.float    "current_rank", limit: 24
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "evaluations", ["user_id"], name: "index_evaluations_on_user_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "evaluation_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "notes", ["evaluation_id"], name: "index_notes_on_evaluation_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string   "model_class", limit: 255
    t.string   "action",      limit: 255
    t.integer  "role_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "permissions", ["role_id"], name: "index_permissions_on_role_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",                 limit: 4
    t.date     "start_training_date"
    t.date     "leave_date"
    t.date     "finish_training_date"
    t.boolean  "ready_for_project"
    t.date     "contract_date"
    t.string   "naitei_company",          limit: 255
    t.integer  "trainer_id",              limit: 4
    t.date     "graduation"
    t.integer  "user_type_id",            limit: 4
    t.integer  "university_id",           limit: 4
    t.integer  "programming_language_id", limit: 4
    t.integer  "user_progress_id",        limit: 4
    t.integer  "status_id",               limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "programming_languages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.integer  "begin_point", limit: 4
    t.integer  "end_point",   limit: 4
    t.float    "rank_value",  limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.boolean  "allow_access_admin"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "avatar",      limit: 255
    t.text     "description", limit: 65535
    t.text     "content",     limit: 65535
    t.integer  "during_time", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "task_masters", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "avatar",      limit: 255
    t.text     "description", limit: 65535
    t.text     "content",     limit: 65535
    t.integer  "subject_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "task_masters", ["subject_id"], name: "index_task_masters_on_subject_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "avatar",              limit: 255
    t.text     "description",         limit: 65535
    t.text     "content",             limit: 65535
    t.integer  "task_master_id",      limit: 4
    t.integer  "assigned_trainee_id", limit: 4
    t.integer  "course_subject_id",   limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "tasks", ["course_subject_id"], name: "index_tasks_on_course_subject_id", using: :btree

  create_table "universities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_courses", force: :cascade do |t|
    t.boolean  "active",               default: true
    t.integer  "user_id",    limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "user_courses", ["user_id", "course_id"], name: "index_user_courses_on_user_id_and_course_id", unique: true, using: :btree

  create_table "user_progresses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_subjects", force: :cascade do |t|
    t.integer  "status",                 limit: 4, default: 0
    t.integer  "user_id",                limit: 4
    t.integer  "course_id",              limit: 4
    t.integer  "user_course_id",         limit: 4
    t.integer  "course_subject_id",      limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "during_time",            limit: 4, default: 0
    t.integer  "total_time_task_closed", limit: 4, default: 0
    t.integer  "progress",               limit: 4, default: 0
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "user_subjects", ["course_id"], name: "index_user_subjects_on_course_id", using: :btree
  add_index "user_subjects", ["course_subject_id"], name: "index_user_subjects_on_course_subject_id", using: :btree
  add_index "user_subjects", ["user_course_id"], name: "index_user_subjects_on_user_course_id", using: :btree
  add_index "user_subjects", ["user_id"], name: "index_user_subjects_on_user_id", using: :btree

  create_table "user_tasks", force: :cascade do |t|
    t.integer  "task_id",         limit: 4
    t.integer  "user_subject_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "progress",        limit: 4, default: 0
    t.integer  "spent_time",      limit: 4
    t.integer  "estimated_time",  limit: 4
    t.integer  "redmine_task_id", limit: 4
    t.integer  "status",          limit: 4, default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "user_tasks", ["task_id"], name: "index_user_tasks_on_task_id", using: :btree
  add_index "user_tasks", ["user_id"], name: "index_user_tasks_on_user_id", using: :btree
  add_index "user_tasks", ["user_subject_id"], name: "index_user_tasks_on_user_subject_id", using: :btree

  create_table "user_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "role_id",                limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "course_subjects", "courses"
  add_foreign_key "course_subjects", "subjects"
  add_foreign_key "evaluation_details", "evaluation_templates"
  add_foreign_key "evaluation_details", "evaluations"
  add_foreign_key "evaluations", "users"
  add_foreign_key "notes", "evaluations"
  add_foreign_key "permissions", "roles"
  add_foreign_key "profiles", "users"
  add_foreign_key "task_masters", "subjects"
  add_foreign_key "tasks", "course_subjects", on_delete: :cascade
  add_foreign_key "user_subjects", "course_subjects", on_delete: :cascade
  add_foreign_key "user_subjects", "courses"
  add_foreign_key "user_subjects", "user_courses"
  add_foreign_key "user_subjects", "users"
  add_foreign_key "user_tasks", "tasks", on_delete: :cascade
  add_foreign_key "user_tasks", "user_subjects", on_delete: :cascade
  add_foreign_key "user_tasks", "users"
  add_foreign_key "users", "roles"
end
