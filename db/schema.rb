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

ActiveRecord::Schema[7.1].define(version: 2024_04_19_202713) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nav_questionnaire_rules", force: :cascade do |t|
    t.string "question_key"
    t.datetime "deleted_at"
    t.bigint "nav_questionnaire_id"
    t.bigint "nav_rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nav_questionnaire_id"], name: "index_nav_questionnaire_rules_on_nav_questionnaire_id"
    t.index ["nav_rule_id"], name: "index_nav_questionnaire_rules_on_nav_rule_id"
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

  create_table "nav_rules", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.jsonb "data", default: {}
    t.datetime "deleted_at"
    t.bigint "dc_company_id"
    t.bigint "dc_company_employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dc_company_employee_id"], name: "index_nav_rules_on_dc_company_employee_id"
    t.index ["dc_company_id"], name: "index_nav_rules_on_dc_company_id"
  end

  add_foreign_key "nav_questionnaire_rules", "nav_questionnaires", on_delete: :cascade
  add_foreign_key "nav_questionnaire_rules", "nav_rules", on_delete: :cascade
  add_foreign_key "nav_questionnaires", "dc_companies", on_delete: :cascade
  add_foreign_key "nav_questionnaires", "dc_company_employees"
  add_foreign_key "nav_rules", "dc_companies", on_delete: :cascade
  add_foreign_key "nav_rules", "dc_company_employees"
end
