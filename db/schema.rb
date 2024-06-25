# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_25_165419) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "nav_action_types", force: :cascade do |t|
    t.string "title"
    t.string "action_kind"
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nav_actions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "action_kind"
  end

  create_table "nav_active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_nav_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "nav_index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "nav_active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_nav_active_storage_blobs_on_key", unique: true
  end

  create_table "nav_active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "nav_index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "nav_activities", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "deleted_at"
    t.bigint "dc_company_id"
    t.bigint "dc_company_employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dc_company_employee_id"], name: "index_nav_activities_on_dc_company_employee_id"
    t.index ["dc_company_id"], name: "index_nav_activities_on_dc_company_id"
    t.index ["title", "dc_company_id"], name: "index_nav_activities_on_title_and_dc_company_id", unique: true
  end

  create_table "nav_activity_actions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.jsonb "details", default: {}
    t.integer "order"
    t.datetime "deleted_at"
    t.bigint "nav_action_id"
    t.bigint "nav_activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nav_action_id"], name: "index_nav_activity_actions_on_nav_action_id"
    t.index ["nav_activity_id"], name: "index_nav_activity_actions_on_nav_activity_id"
    t.index ["title", "nav_activity_id"], name: "index_nav_activity_actions_on_title_and_nav_activity_id", unique: true
  end

  create_table "nav_activity_triggers", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.jsonb "criteria", default: {}
    t.datetime "deleted_at"
    t.bigint "nav_questionnaire_id"
    t.bigint "nav_activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nav_activity_id"], name: "index_nav_activity_triggers_on_nav_activity_id"
    t.index ["nav_questionnaire_id"], name: "index_nav_activity_triggers_on_nav_questionnaire_id"
  end

  create_table "nav_assessment_action_results", force: :cascade do |t|
    t.jsonb "result_data", default: {}
    t.bigint "nav_activity_action_id"
    t.bigint "nav_assessment_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "nav_activity_trigger_id"
    t.index ["nav_activity_action_id"], name: "index_nav_assessment_action_results_on_nav_activity_action_id"
    t.index ["nav_activity_trigger_id"], name: "index_nav_assessment_action_results_on_nav_activity_trigger_id"
    t.index ["nav_assessment_id"], name: "index_nav_assessment_action_results_on_nav_assessment_id"
  end

  create_table "nav_assessments", force: :cascade do |t|
    t.string "title"
    t.jsonb "form_data", default: {}
    t.bigint "nav_questionnaire_id"
    t.bigint "dc_company_id"
    t.bigint "dc_company_employee_id"
    t.bigint "account_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_nav_assessments_on_account_id"
    t.index ["dc_company_employee_id"], name: "index_nav_assessments_on_dc_company_employee_id"
    t.index ["dc_company_id"], name: "index_nav_assessments_on_dc_company_id"
    t.index ["nav_questionnaire_id"], name: "index_nav_assessments_on_nav_questionnaire_id"
  end

  create_table "nav_questionnaire_actions", force: :cascade do |t|
    t.jsonb "criteria", default: {}
    t.datetime "deleted_at"
    t.bigint "nav_action_id"
    t.bigint "nav_questionnaire_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nav_action_id"], name: "index_nav_questionnaire_actions_on_nav_action_id"
    t.index ["nav_questionnaire_id"], name: "index_nav_questionnaire_actions_on_nav_questionnaire_id"
  end

  create_table "nav_questionnaires", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.jsonb "form_json", default: {}
    t.datetime "deleted_at"
    t.bigint "dc_company_id"
    t.bigint "dc_company_employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dc_company_employee_id"], name: "index_nav_questionnaires_on_dc_company_employee_id"
    t.index ["dc_company_id"], name: "index_nav_questionnaires_on_dc_company_id"
  end

  add_foreign_key "nav_active_storage_attachments", "nav_active_storage_blobs", column: "blob_id"
  add_foreign_key "nav_active_storage_variant_records", "nav_active_storage_blobs", column: "blob_id"
  add_foreign_key "nav_activities", "dc_companies", on_delete: :cascade
  add_foreign_key "nav_activities", "dc_company_employees"
  add_foreign_key "nav_activity_actions", "nav_actions", on_delete: :cascade
  add_foreign_key "nav_activity_actions", "nav_activities", on_delete: :cascade
  add_foreign_key "nav_activity_triggers", "nav_activities", on_delete: :cascade
  add_foreign_key "nav_activity_triggers", "nav_questionnaires", on_delete: :cascade
  add_foreign_key "nav_assessment_action_results", "nav_activity_actions"
  add_foreign_key "nav_assessment_action_results", "nav_activity_triggers"
  add_foreign_key "nav_assessment_action_results", "nav_assessments", on_delete: :cascade
  add_foreign_key "nav_assessments", "dc_companies", column: "account_id"
  add_foreign_key "nav_assessments", "dc_companies", on_delete: :cascade
  add_foreign_key "nav_assessments", "dc_company_employees"
  add_foreign_key "nav_assessments", "nav_questionnaires", on_delete: :cascade
  add_foreign_key "nav_questionnaire_actions", "nav_actions", on_delete: :cascade
  add_foreign_key "nav_questionnaire_actions", "nav_questionnaires", on_delete: :cascade
  add_foreign_key "nav_questionnaires", "dc_companies", on_delete: :cascade
  add_foreign_key "nav_questionnaires", "dc_company_employees"
end
