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

ActiveRecord::Schema[7.1].define(version: 2024_10_31_174059) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "acord_category", id: false, force: :cascade do |t|
    t.integer "catid", null: false
    t.string "catgroup", limit: 10
    t.string "catname", limit: 10
    t.string "catdesc", limit: 50
  end

  create_table "acord_currency", id: :integer, default: nil, force: :cascade do |t|
    t.string "currencycode", limit: 256
    t.string "conversionrateref", limit: 256
    t.string "sourcesystemref", limit: 256
    t.integer "amount"
  end

  create_table "acord_cyberliability", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.string "miscparty", limit: 256
    t.string "coverage", limit: 256
    t.string "commlcoverage", limit: 256
    t.string "coverageavailable", limit: 256
    t.string "pcicd", limit: 256
    t.string "grossreceipts", limit: 256
    t.string "questionanswer", limit: 256
    t.string "cyberliabilitylinebusinessext", limit: 256
    t.string "lobcd", limit: 256
    t.string "lobsubcd", limit: 256
    t.string "naiccd", limit: 256
    t.string "companyproductcd", limit: 256
    t.string "currenttermamt", limit: 256
    t.string "netchangeamt", limit: 256
    t.string "writtenamt", limit: 256
    t.string "groupid", limit: 256
    t.string "pmacd", limit: 256
    t.string "rateeffectivedt", limit: 256
    t.string "additionalinterest", limit: 256
    t.string "minpremind", limit: 256
    t.string "auditinfo", limit: 256
    t.string "hazardgradecd", limit: 256
    t.string "minpremamt", limit: 256
    t.string "hazardgradeinfo", limit: 256
    t.string "sourcesystemref", limit: 256
  end

  create_table "acord_datatypes", id: :integer, default: nil, force: :cascade do |t|
    t.string "reftablecode", limit: 256
    t.string "codelistref", limit: 256
    t.string "sourcesystemref", limit: 256
    t.string "domain", limit: 256
    t.string "value", limit: 256
  end

  create_table "acord_datatypesreftablecode", id: :integer, default: nil, force: :cascade do |t|
    t.string "refcode", limit: 256, null: false
    t.string "tablename", limit: 256, null: false
  end

  create_table "acord_formdata", id: :bigint, default: nil, force: :cascade do |t|
    t.string "submissionid", limit: 256, null: false
    t.string "formdata", limit: 65535
    t.string "currentdate", limit: 25
    t.string "formid", limit: 256
    t.string "partner", limit: 50
    t.string "userid", limit: 50
    t.string "version", limit: 10
    t.string "transactionseqnumber", limit: 5
  end

  create_table "acord_link", id: :integer, default: nil, force: :cascade do |t|
    t.string "relation", limit: 256
    t.string "href", limit: 256
    t.string "title", limit: 256
    t.integer "linkcd"
  end

  create_table "acord_miscparty", id: :integer, default: nil, force: :cascade do |t|
    t.string "sourcesystemref", limit: 25
    t.string "link", limit: 5
    t.string "nameinfo", limit: 5
    t.string "partytypecd", limit: 5
    t.string "relationship", limit: 5
    t.string "name", limit: 255
    t.string "indexname", limit: 25
    t.string "taxidentity", limit: 5
  end

  create_table "app_active_admin_comments", id: :bigint, default: -> { "nextval('active_admin_comments_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "app_active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_app_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_app_active_storage_attachments_uniqueness", unique: true
  end

  create_table "app_active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.string "service_name", null: false
    t.index ["key"], name: "index_app_active_storage_blobs_on_key", unique: true
  end

  create_table "app_active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_app_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "app_admin_settings", id: :bigint, default: -> { "nextval('admin_settings_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "cell"
    t.bigint "agency_id"
    t.integer "admin_timeout", default: 30
    t.boolean "timeout_setting"
    t.integer "reminder_email_timeframe", default: 7
    t.boolean "system_password"
    t.boolean "edit_applications"
    t.integer "availability_stop"
    t.datetime "deleted_at", precision: nil
    t.index ["agency_id"], name: "index_admin_settings_on_agency_id"
  end

  create_table "app_admin_users", id: :bigint, default: -> { "nextval('admin_users_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "deleted_at", precision: nil
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_admin_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_admin_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_admin_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_admin_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "app_aes_tokens", id: :bigint, default: -> { "nextval('aes_tokens_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "app_agencies", id: :bigint, default: -> { "nextval('agencies_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "title"
    t.string "website"
    t.string "address_1"
    t.string "city"
    t.string "zip_code"
    t.string "state"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.json "logo"
    t.string "address_2"
    t.string "agency_code"
    t.bigint "license_no"
    t.bigint "parent_id"
    t.integer "agency_type", default: 0
    t.integer "agency_category", default: 3
    t.text "sis_agency_guid"
    t.boolean "sis", default: false
    t.string "ss_number"
    t.boolean "ghost_agency", default: false
    t.string "guid"
    t.boolean "active", default: true
    t.integer "number_of_agents_limit"
    t.datetime "deleted_at", precision: nil
    t.integer "premium_extraction_limit"
    t.integer "qubi_company_id"
    t.boolean "guest", default: false, null: false
    t.index ["parent_id"], name: "index_agencies_on_parent_id"
  end

  create_table "app_agency_email_preferences", force: :cascade do |t|
    t.bigint "agency_id"
    t.bigint "email_preference_id"
    t.boolean "active", default: true
    t.bigint "company_id"
    t.index ["agency_id"], name: "index_app_agency_email_preferences_on_app_agency_id"
    t.index ["company_id"], name: "index_app_agency_email_preferences_on_company_id"
    t.index ["email_preference_id"], name: "index_app_agency_email_preferences_on_email_preference_id"
  end

  create_table "app_agency_features", id: :bigint, default: -> { "nextval('agency_features_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "feature_id"
    t.bigint "agency_id"
    t.boolean "active", default: true
    t.datetime "deleted_at", precision: nil
    t.bigint "company_id"
    t.index ["agency_id"], name: "index_agency_features_on_agency_id"
    t.index ["company_id"], name: "index_app_agency_features_on_company_id"
    t.index ["feature_id"], name: "index_agency_features_on_feature_id"
  end

  create_table "app_agency_templates", id: :bigint, default: -> { "nextval('agency_templates_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "agency_id"
    t.bigint "template_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "assigned_by_agency_id"
    t.datetime "deleted_at", precision: nil
    t.bigint "company_id"
    t.index ["agency_id"], name: "index_agency_templates_on_agency_id"
    t.index ["assigned_by_agency_id"], name: "index_agency_templates_on_assigned_by_agency_id"
    t.index ["company_id"], name: "index_app_agency_templates_on_company_id"
    t.index ["template_id"], name: "index_agency_templates_on_template_id"
  end

  create_table "app_agency_themes", id: :bigint, default: -> { "nextval('agency_themes_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "theme_id"
    t.bigint "agency_id"
    t.boolean "selected"
    t.boolean "active"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.bigint "company_id"
    t.index ["agency_id"], name: "index_agency_themes_on_agency_id"
    t.index ["company_id"], name: "index_app_agency_themes_on_company_id"
    t.index ["theme_id"], name: "index_agency_themes_on_theme_id"
  end

  create_table "app_agent_agencies", id: :bigint, default: -> { "nextval('agent_agencies_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "agent_id"
    t.bigint "agency_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["agency_id"], name: "index_agent_agencies_on_agency_id"
    t.index ["agent_id"], name: "index_agent_agencies_on_agent_id"
  end

  create_table "app_agent_features", id: :bigint, default: -> { "nextval('agent_features_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "feature_id"
    t.bigint "agent_id"
    t.boolean "active", default: true
    t.datetime "deleted_at", precision: nil
    t.bigint "company_employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_agent_features_on_agent_id"
    t.index ["company_employee_id"], name: "index_app_agent_features_on_company_employee_id"
    t.index ["feature_id"], name: "index_agent_features_on_feature_id"
  end

  create_table "app_agent_themes", id: :bigint, default: -> { "nextval('agent_themes_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "agency_theme_id"
    t.bigint "agent_id"
    t.boolean "selected"
    t.boolean "active"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.bigint "company_employee_id"
    t.index ["agency_theme_id"], name: "index_agent_themes_on_agency_theme_id"
    t.index ["agent_id"], name: "index_agent_themes_on_agent_id"
    t.index ["company_employee_id"], name: "index_app_agent_themes_on_company_employee_id"
  end

  create_table "app_agents", id: :bigint, default: -> { "nextval('agents_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "agency_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.integer "applications_count", default: 0
    t.string "agent_code"
    t.json "profile_picture"
    t.integer "agent_type"
    t.text "email_signature"
    t.bigint "license_no"
    t.bigint "sis_profile_id"
    t.bigint "sis_employee_id"
    t.boolean "sis_agent_is_active"
    t.text "address1"
    t.text "address2"
    t.text "city"
    t.text "state"
    t.string "zip_code"
    t.string "phone"
    t.date "hire_date"
    t.string "sis_title"
    t.date "birth_date"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "cognito_username"
    t.boolean "active", default: true
    t.string "uuid"
    t.datetime "deleted_at", precision: nil
    t.integer "qubi_employee_id"
    t.index ["agency_id"], name: "index_agents_on_agency_id"
    t.index ["confirmation_token"], name: "index_agents_on_confirmation_token", unique: true
    t.index ["email", "agency_id"], name: "index_agents_on_email_and_agency_id", unique: true
    t.index ["invitation_token"], name: "index_agents_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_agents_on_invitations_count"
    t.index ["invited_by_id"], name: "index_agents_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_agents_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_agents_on_uuid", unique: true
  end

  create_table "app_application_link_documents", id: :bigint, default: -> { "nextval('application_link_documents_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "application_link_id"
    t.bigint "document_id"
    t.datetime "deleted_at", precision: nil
    t.index ["application_link_id"], name: "index_application_link_documents_on_application_link_id"
    t.index ["document_id"], name: "index_application_link_documents_on_document_id"
  end

  create_table "app_application_link_schedule_templates", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "application_link_id", null: false
    t.bigint "schedule_template_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_link_id"], name: "index_on_application_link_id"
    t.index ["schedule_template_id"], name: "index_on_schedule_template_id"
    t.index ["uuid"], name: "index_app_application_link_schedule_templates_on_uuid", unique: true
  end

  create_table "app_application_link_templates", id: :bigint, default: -> { "nextval('application_link_templates_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "template_id"
    t.bigint "application_link_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["application_link_id"], name: "index_application_link_templates_on_application_link_id"
    t.index ["template_id"], name: "index_application_link_templates_on_template_id"
  end

  create_table "app_application_links", id: :bigint, default: -> { "nextval('application_links_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "identifier"
    t.boolean "active"
    t.string "title"
    t.text "description"
    t.bigint "agency_id"
    t.bigint "agent_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.bigint "company_employee_id"
    t.bigint "company_id", null: false
    t.index ["agency_id"], name: "index_application_links_on_agency_id"
    t.index ["agent_id"], name: "index_application_links_on_agent_id"
    t.index ["company_employee_id"], name: "index_app_application_links_on_company_employee_id"
  end

  create_table "app_clients", id: :bigint, default: -> { "nextval('clients_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: ""
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.json "profile_picture"
    t.string "application_invitable_type"
    t.bigint "application_invitable_id"
    t.integer "client_type", default: 0
    t.string "company_name"
    t.string "tax_id"
    t.string "auth_token"
    t.text "sis_client_code"
    t.bigint "sis_client_id"
    t.boolean "is_prospect"
    t.string "uuid"
    t.datetime "deleted_at", precision: nil
    t.index ["application_invitable_type", "application_invitable_id"], name: "application_invitable_type_and_application_invitable_id"
    t.index ["invitation_token"], name: "index_clients_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_clients_on_invitations_count"
    t.index ["invited_by_id"], name: "index_clients_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_clients_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_clients_on_uuid", unique: true
  end

  create_table "app_derived_submission_groups", id: :bigint, default: -> { "nextval('derived_submission_groups_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "base_submission_group_id", null: false
    t.bigint "received_submission_group_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.bigint "dc_company_connection_id"
    t.index ["base_submission_group_id"], name: "index_derived_submission_groups_on_base_submission_group_id"
    t.index ["dc_company_connection_id"], name: "index_app_derived_submission_groups_on_dc_company_connection_id"
    t.index ["received_submission_group_id"], name: "index_derived_submission_groups_on_received_submission_group_id"
  end

  create_table "app_digitize_documents", id: :bigint, default: -> { "nextval('digitize_documents_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "document_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "reason"
    t.datetime "deleted_at", precision: nil
    t.index ["document_id"], name: "index_digitize_documents_on_document_id"
  end

  create_table "app_documents", id: :bigint, default: -> { "nextval('documents_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name"
    t.string "content_type"
    t.text "key"
    t.bigint "agent_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "description"
    t.bigint "template_id"
    t.string "uuid"
    t.datetime "deleted_at", precision: nil
    t.bigint "company_employee_id"
    t.bigint "company_id"
    t.integer "agency_id"
    t.index ["agent_id"], name: "index_documents_on_agent_id"
    t.index ["company_employee_id"], name: "index_app_documents_on_company_employee_id"
    t.index ["company_id"], name: "index_app_documents_on_company_id"
    t.index ["deleted_at"], name: "index_documents_on_deleted_at"
    t.index ["template_id"], name: "index_documents_on_template_id"
  end

  create_table "app_email_discussions", id: :bigint, default: -> { "nextval('email_discussions_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "content"
    t.bigint "from_agent_id"
    t.bigint "to_agent_id"
    t.bigint "submission_group_id"
    t.bigint "submission_status_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["from_agent_id"], name: "index_email_discussions_on_from_agent_id"
    t.index ["submission_group_id"], name: "index_email_discussions_on_submission_group_id"
    t.index ["submission_status_id"], name: "index_email_discussions_on_submission_status_id"
    t.index ["to_agent_id"], name: "index_email_discussions_on_to_agent_id"
  end

  create_table "app_email_preference_types", force: :cascade do |t|
    t.string "title"
    t.string "description"
  end

  create_table "app_email_preferences", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "key"
    t.bigint "email_preference_type_id"
    t.index ["email_preference_type_id"], name: "index_app_email_preferences_on_email_preference_type_id"
  end

  create_table "app_features", id: :bigint, default: -> { "nextval('features_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "title"
    t.datetime "deleted_at", precision: nil
  end

  create_table "app_insurance_application_documents", id: :bigint, default: -> { "nextval('insurance_application_documents_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "insurance_application_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["document_id"], name: "index_insurance_application_documents_on_document_id"
    t.index ["insurance_application_id"], name: "idx_insurance_app_docs_on_ins_app_id"
  end

  create_table "app_insurance_application_sections", id: :bigint, default: -> { "nextval('insurance_application_sections_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "uuid"
    t.bigint "section_id"
    t.integer "insurance_application_id"
    t.float "progress"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["insurance_application_id"], name: "insurance_application_id_sections"
    t.index ["section_id"], name: "index_insurance_application_sections_on_section_id"
  end

  create_table "app_insurance_applications", id: :bigint, default: -> { "nextval('insurance_applications_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "template_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "client_application_id"
    t.string "client_application_type"
    t.integer "status", default: 0
    t.integer "days", default: 0
    t.bigint "agent_id"
    t.bigint "client_id"
    t.boolean "deleted", default: false
    t.string "app_status", default: "Open"
    t.string "sign_url"
    t.datetime "signed_at_by_agent", precision: nil
    t.datetime "signed_at_by_client", precision: nil
    t.string "signature_request_id"
    t.datetime "completed_at", precision: nil
    t.datetime "mail_reminder_time", precision: nil
    t.text "agent_signature"
    t.text "client_signature"
    t.bigint "renewal_parent_id"
    t.integer "renewal_status"
    t.jsonb "submission_json", default: {}, null: false
    t.string "application_type"
    t.decimal "targetted_premium"
    t.date "targetted_effective_date"
    t.date "quote_needed_date"
    t.boolean "automatic_renewal", default: true
    t.float "percentage_of_completion", default: 0.0, null: false
    t.bigint "application_link_id"
    t.datetime "sent_to_insured_at", precision: nil
    t.string "uuid"
    t.boolean "created_using_pdf", default: false
    t.bigint "submission_group_id"
    t.datetime "deleted_at", precision: nil
    t.jsonb "form_json", default: {}, null: false
    t.index ["agent_id"], name: "index_insurance_applications_on_agent_id"
    t.index ["application_link_id"], name: "index_insurance_applications_on_application_link_id"
    t.index ["client_id"], name: "index_insurance_applications_on_client_id"
    t.index ["submission_group_id"], name: "index_insurance_applications_on_submission_group_id"
    t.index ["template_id"], name: "index_insurance_applications_on_template_id"
    t.index ["uuid"], name: "index_insurance_applications_on_uuid", unique: true
  end

  create_table "app_insured_collaborator_sections", id: :bigint, default: -> { "nextval('insured_collaborator_sections_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "insured_collaborator_id"
    t.bigint "section_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "active", default: true
    t.string "uuid"
    t.datetime "deleted_at", precision: nil
    t.bigint "company_employee_id"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_app_insured_collaborator_sections_on_account_id"
    t.index ["company_employee_id"], name: "index_app_insured_collaborator_sections_on_company_employee_id"
    t.index ["insured_collaborator_id"], name: "index_insured_collaborator_sections_on_insured_collaborator_id"
    t.index ["section_id"], name: "index_insured_collaborator_sections_on_section_id"
  end

  create_table "app_insured_collaborators", id: :bigint, default: -> { "nextval('insured_collaborators_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "uuid", null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "app_markets", force: :cascade do |t|
    t.string "title"
    t.string "product_lines"
    t.string "email"
    t.string "uuid"
    t.datetime "deleted_at"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_app_markets_on_company_id"
  end

  create_table "app_outside_email_histories", id: :bigint, default: -> { "nextval('outside_email_histories_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "email"
    t.integer "sent_count", default: 0
    t.bigint "agent_id"
    t.bigint "insurance_application_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.bigint "company_employee_id"
    t.string "submission_type"
    t.bigint "submission_id"
    t.text "insurance_application_ids"
    t.text "document_ids"
    t.bigint "market_id"
    t.index ["agent_id"], name: "index_outside_email_histories_on_agent_id"
    t.index ["company_employee_id"], name: "index_app_outside_email_histories_on_company_employee_id"
    t.index ["insurance_application_id"], name: "index_outside_email_histories_on_insurance_application_id"
    t.index ["market_id"], name: "index_app_outside_email_histories_on_market_id"
    t.index ["submission_type", "submission_id"], name: "index_outside_email_histories_on_submission"
  end

  create_table "app_partner_agencies", id: :bigint, default: -> { "nextval('partner_agencies_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "agency_id"
    t.bigint "partner_id"
    t.datetime "deleted_at", precision: nil
    t.bigint "company_id"
    t.index ["agency_id", "partner_id"], name: "index_partner_agencies_on_agency_id_and_partner_id", unique: true
    t.index ["agency_id"], name: "index_partner_agencies_on_agency_id"
    t.index ["company_id"], name: "index_app_partner_agencies_on_company_id"
    t.index ["partner_id"], name: "index_partner_agencies_on_partner_id"
  end

  create_table "app_partner_template_mappings", id: :bigint, default: -> { "nextval('partner_template_mappings_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "template_mapping_id"
    t.bigint "partner_id"
    t.datetime "deleted_at", precision: nil
    t.index ["partner_id"], name: "index_partner_template_mappings_on_partner_id"
    t.index ["template_mapping_id", "partner_id"], name: "index_partner_and_template_mapping", unique: true
    t.index ["template_mapping_id"], name: "index_partner_template_mappings_on_template_mapping_id"
  end

  create_table "app_partners", id: :bigint, default: -> { "nextval('partners_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "app_pdf_document_configuration_templates", id: :bigint, default: -> { "nextval('pdf_document_configuration_templates_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "template_id"
    t.bigint "pdf_document_configuration_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["pdf_document_configuration_id"], name: "index_pdf_doc_cfg_templates_on_pdf_doc_cfg_id"
    t.index ["template_id"], name: "index_pdf_document_configuration_templates_on_template_id"
  end

  create_table "app_pdf_document_configurations", id: :bigint, default: -> { "nextval('pdf_document_configurations_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "uuid"
    t.string "name"
    t.bigint "pdf_document_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["pdf_document_type_id"], name: "index_pdf_document_configurations_on_pdf_document_type_id"
  end

  create_table "app_pdf_document_types", id: :bigint, default: -> { "nextval('pdf_document_types_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "uuid"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "app_pdf_extraction_mappings", id: :bigint, default: -> { "nextval('pdf_extraction_mappings_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "key"
    t.integer "table", default: 0
    t.integer "field", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "app_pdf_extractions", id: :bigint, default: -> { "nextval('pdf_extractions_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "uuid"
    t.integer "extraction_type", default: 0
    t.text "response"
    t.string "extractable_type"
    t.bigint "extractable_id"
    t.bigint "agency_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "template_id"
    t.text "uploaded_pdf_key"
    t.datetime "deleted_at", precision: nil
    t.bigint "company_id"
    t.bigint "company_employee_id"
    t.index ["agency_id"], name: "index_pdf_extractions_on_agency_id"
    t.index ["company_employee_id"], name: "index_app_pdf_extractions_on_company_employee_id"
    t.index ["company_id"], name: "index_app_pdf_extractions_on_company_id"
    t.index ["extractable_id", "extractable_type"], name: "index_pdf_extractions_on_extractable_id_and_extractable_type"
    t.index ["extractable_type", "extractable_id"], name: "index_pdf_extractions_on_extractable_type_and_extractable_id"
    t.index ["template_id"], name: "index_pdf_extractions_on_template_id"
  end

  create_table "app_request_agents", id: :bigint, default: -> { "nextval('request_agents_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "requested_by_agent_id"
    t.bigint "requested_agent_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["requested_agent_id"], name: "index_request_agents_on_requested_agent_id"
    t.index ["requested_by_agent_id"], name: "index_request_agents_on_requested_by_agent_id"
  end

  create_table "app_schedule_templates", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.jsonb "required_fieldset", default: [], null: false, array: true
    t.bigint "agent_id"
    t.string "uuid", null: false
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "company_employee_id"
    t.bigint "company_id"
    t.index ["agent_id"], name: "index_app_schedule_templates_on_agent_id"
    t.index ["company_employee_id"], name: "index_app_schedule_templates_on_company_employee_id"
    t.index ["company_id"], name: "index_app_schedule_templates_on_company_id"
    t.index ["uuid"], name: "index_app_schedule_templates_on_uuid", unique: true
  end

  create_table "app_sections", id: :bigint, default: -> { "nextval('sections_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "uuid"
    t.string "key"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "form_json", default: {}, null: false
    t.bigint "insurance_application_id"
    t.datetime "deleted_at", precision: nil
    t.index ["insurance_application_id"], name: "index_sections_on_insurance_application_id"
  end

  create_table "app_submission_group_agencies", id: :bigint, default: -> { "nextval('submission_group_agencies_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "submission_group_id"
    t.bigint "agency_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.bigint "company_id"
    t.index ["agency_id"], name: "index_submission_group_agencies_on_agency_id"
    t.index ["company_id"], name: "index_app_submission_group_agencies_on_company_id"
    t.index ["submission_group_id"], name: "index_submission_group_agencies_on_submission_group_id"
  end

  create_table "app_submission_group_agents", id: :bigint, default: -> { "nextval('submission_group_agents_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "submission_group_id", null: false
    t.bigint "agent_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.bigint "company_employee_id"
    t.index ["agent_id"], name: "index_submission_group_agents_on_agent_id"
    t.index ["company_employee_id"], name: "index_app_submission_group_agents_on_company_employee_id"
    t.index ["submission_group_id"], name: "index_submission_group_agents_on_submission_group_id"
  end

  create_table "app_submission_group_documents", id: :bigint, default: -> { "nextval('submission_group_documents_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "submission_group_id", null: false
    t.bigint "document_id", null: false
    t.text "document_key"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "active", default: true
    t.datetime "deleted_at", precision: nil
    t.index ["document_id"], name: "index_submission_group_documents_on_document_id"
    t.index ["submission_group_id"], name: "index_submission_group_documents_on_submission_group_id"
  end

  create_table "app_submission_group_notes", id: :bigint, default: -> { "nextval('submission_group_notes_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "content"
    t.string "sender_type"
    t.bigint "sender_id"
    t.string "receiver_type"
    t.bigint "receiver_id"
    t.bigint "submission_group_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["receiver_type", "receiver_id"], name: "index_submission_group_notes_on_receiver_type_and_receiver_id"
    t.index ["sender_type", "sender_id"], name: "index_submission_group_notes_on_sender_type_and_sender_id"
    t.index ["submission_group_id"], name: "index_submission_group_notes_on_submission_group_id"
  end

  create_table "app_submission_group_schedule_templates", force: :cascade do |t|
    t.string "uuid", null: false
    t.bigint "submission_group_id", null: false
    t.bigint "schedule_template_id", null: false
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["schedule_template_id"], name: "schedule_template_id_on_submission_group_schedule_templates"
    t.index ["submission_group_id"], name: "submission_group_id_on_submission_group_schedule_templates"
    t.index ["uuid"], name: "app_submission_schedule_templates", unique: true
  end

  create_table "app_submission_group_schedules", force: :cascade do |t|
    t.string "uuid", null: false
    t.jsonb "schedule_data", default: [], null: false, array: true
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "app_submission_group_schedule_template_id"
    t.index ["app_submission_group_schedule_template_id"], name: "submission_schedule_template_id_on_submission_schedules"
    t.index ["uuid"], name: "index_app_submission_group_schedules_on_uuid", unique: true
  end

  create_table "app_submission_groups", id: :bigint, default: -> { "nextval('submission_groups_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "uuid"
    t.bigint "agent_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "title"
    t.bigint "agency_id"
    t.integer "status", default: 0
    t.bigint "client_id"
    t.datetime "sent_to_insured_at", precision: nil
    t.bigint "status_id"
    t.integer "targeted_premium"
    t.integer "quote"
    t.datetime "quote_set_at", precision: nil
    t.datetime "quote_date", precision: nil
    t.datetime "effective_date", precision: nil
    t.boolean "deleted", default: false
    t.datetime "requested_effective_date", precision: nil
    t.datetime "deleted_at", precision: nil
    t.datetime "expiry_date", precision: nil
    t.boolean "renewal_flag", default: false
    t.bigint "company_id"
    t.bigint "company_employee_id"
    t.bigint "account_id"
    t.integer "qubi_submission_id"
    t.datetime "reminded_at"
    t.index ["account_id"], name: "index_app_submission_groups_on_account_id"
    t.index ["agency_id"], name: "index_submission_groups_on_agency_id"
    t.index ["agent_id"], name: "index_submission_groups_on_agent_id"
    t.index ["client_id"], name: "index_submission_groups_on_client_id"
    t.index ["company_employee_id"], name: "index_app_submission_groups_on_company_employee_id"
    t.index ["company_id"], name: "index_app_submission_groups_on_company_id"
    t.index ["status_id"], name: "index_submission_groups_on_status_id"
  end

  create_table "app_submission_statuses", id: :bigint, default: -> { "nextval('submission_statuses_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name"
    t.boolean "only_for_underwriter", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "agency_types"
    t.datetime "deleted_at", precision: nil
  end

  create_table "app_template_mappings", id: :bigint, default: -> { "nextval('template_mappings_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "template_id"
    t.jsonb "mapped_json", default: {}, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "mapping_for", default: 0
    t.datetime "deleted_at", precision: nil
    t.index ["template_id"], name: "index_template_mappings_on_template_id"
  end

  create_table "app_templates", id: :bigint, default: -> { "nextval('templates_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "wholesaler_id"
    t.string "class_name"
    t.string "title", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "approximate_minutes", default: 1
    t.boolean "e_signature_flag", default: true
    t.text "frevvo_form_url"
    t.integer "renewal_template_id"
    t.integer "template_type"
    t.text "url_name"
    t.jsonb "form_json", default: {}, null: false
    t.text "formio_url"
    t.string "fillable_pdf_id"
    t.string "uuid"
    t.jsonb "form_conditions_json", default: {}
    t.datetime "deleted_at", precision: nil
    t.string "version"
    t.index ["uuid"], name: "index_templates_on_uuid", unique: true
    t.index ["version", "title"], name: "index_app_templates_on_version_and_title", unique: true
    t.index ["wholesaler_id"], name: "index_templates_on_wholesaler_id"
  end

  create_table "app_themes", id: :bigint, default: -> { "nextval('themes_id_seq'::regclass)" }, force: :cascade do |t|
    t.text "title"
    t.jsonb "theme", default: {}, null: false
    t.boolean "active"
    t.integer "theme_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "app_versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.string "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.string "whodunnit_type"
    t.text "object"
    t.text "object_changes"
    t.datetime "created_at", precision: nil
    t.index ["item_type", "item_id"], name: "index_app_versions_on_item_type_and_item_id"
  end

  create_table "compan_type_id", id: false, force: :cascade do |t|
    t.bigint "id"
  end

  create_table "company_type_id", id: false, force: :cascade do |t|
    t.bigint "id"
  end

  create_table "dc_address_box", force: :cascade do |t|
    t.string "street_1"
    t.string "street_2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.bigint "source_id"
    t.string "source_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.datetime "deleted_at", precision: nil
  end

  create_table "dc_authentication_codes", force: :cascade do |t|
    t.bigint "company_employee_id", null: false
    t.string "code", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_dc_authentication_codes_on_code", unique: true
    t.index ["company_employee_id"], name: "index_dc_authentication_codes_on_company_employee_id"
  end

  create_table "dc_cognito", id: :integer, default: nil, force: :cascade do |t|
    t.integer "dc_company_id"
    t.string "provider", null: false
    t.string "name"
    t.string "authority"
    t.string "metadata"
    t.string "audience"
    t.string "clientid", null: false
    t.string "clientsecret", null: false
    t.string "response_type"
    t.string "callback_url"
    t.string "login_url"
    t.string "logout_url"
    t.string "region", null: false
    t.string "user_pool_id", null: false
    t.string "attribute1"
    t.string "attribute2"
    t.string "attribute3"
  end

  create_table "dc_companies", force: :cascade do |t|
    t.string "title"
    t.string "industry"
    t.bigint "comp_type_id", null: false
    t.string "type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "website"
    t.integer "number_of_employees_limit"
    t.string "uuid"
    t.string "logo"
    t.string "license_no"
    t.string "sis_company_guid"
    t.boolean "sis"
    t.string "ss_number"
    t.string "company_code"
    t.boolean "ghost_agency"
    t.bigint "agency_id"
    t.datetime "deleted_at", precision: nil
    t.boolean "ghost_company", default: false
    t.integer "client_id"
    t.string "admin_email"
    t.string "phone_number"
    t.integer "premium_extraction_limit"
    t.boolean "guest_company", default: false, null: false
    t.boolean "guest_agency", default: false
    t.string "test", limit: 10
    t.string "guid"
    t.index ["comp_type_id"], name: "index_dc_companies_on_dc_company_type_id"
  end

  create_table "dc_company_connections", force: :cascade do |t|
    t.bigint "dc_company_id", null: false
    t.bigint "dc_partner_company_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.index ["dc_company_id", "dc_partner_company_id"], name: "index_dc_company_connections_on_company_id_and_dc_partner_compa", unique: true
  end

  create_table "dc_company_employees", force: :cascade do |t|
    t.bigint "dc_company_id", null: false
    t.bigint "dc_employee_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.string "uuid"
    t.integer "sis_employee_id"
    t.string "employee_type"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.integer "agent_id"
    t.integer "client_id"
    t.string "auth_token"
    t.integer "insured_collaborator_id"
    t.string "employee_types"
    t.index ["dc_company_id", "dc_employee_id", "sis_employee_id"], name: "idx_unique_company_employee_sis_id", unique: true
    t.index ["dc_company_id", "dc_employee_id"], name: "idx_dc_company_employee_unique", unique: true
    t.index ["dc_employee_id", "dc_company_id"], name: "unique_dc_employee_company", unique: true
  end

  create_table "dc_company_types", force: :cascade do |t|
    t.string "name"
    t.string "linked_with"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "dc_employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "cognito_username"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "uuid"
    t.string "employee_code"
    t.string "license_no"
    t.datetime "birth_date", precision: nil
    t.string "employee_from", limit: 255
    t.string "phone_number"
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_token_sent_at", precision: nil
    t.index ["email"], name: "index_dc_employees_on_email", unique: true
  end

  create_table "dc_roles", id: :integer, default: nil, force: :cascade do |t|
    t.string "role_code", limit: 5, null: false
    t.string "role_desc", limit: 50, null: false
    t.integer "comp_type_id", null: false
  end

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

  create_table "nav_assessment_action_result_triggers", force: :cascade do |t|
    t.bigint "activity_trigger_id", null: false
    t.bigint "assessment_action_result_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_trigger_id", "assessment_action_result_id"], name: "index_nav_assessment_action_result_triggers", unique: true
    t.index ["activity_trigger_id"], name: "idx_on_activity_trigger_id_f0764e8a7a"
    t.index ["assessment_action_result_id"], name: "idx_on_assessment_action_result_id_d43978073e"
  end

  create_table "nav_assessment_action_results", force: :cascade do |t|
    t.jsonb "result_data", default: {}
    t.bigint "nav_activity_action_id"
    t.bigint "nav_assessment_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "nav_activity_trigger_id"
    t.datetime "completed_at"
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
    t.bigint "tis_order_id"
    t.datetime "completed_at"
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

  create_table "ocr_active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_ocr_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_ocr_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_ocr_active_admin_comments_on_resource"
  end

  create_table "ocr_active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_ocr_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "ocr_index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "ocr_active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_ocr_active_storage_blobs_on_key", unique: true
  end

  create_table "ocr_active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "ocr_index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ocr_admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_ocr_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_ocr_admin_users_on_reset_password_token", unique: true
  end

  create_table "ocr_api_clients", force: :cascade do |t|
    t.string "uuid"
    t.string "name", null: false
    t.string "email"
    t.string "cognito_username"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "client_id"
    t.string "client_secret"
    t.string "reporting_email"
  end

  create_table "ocr_application_mappings", force: :cascade do |t|
    t.string "uuid"
    t.bigint "ocr_api_client_id"
    t.bigint "ocr_application_version_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "mapped_json"
    t.bigint "ocr_application_id"
    t.bigint "ocr_pdf_configuration_id"
    t.index ["ocr_api_client_id"], name: "index_ocr_application_mappings_on_ocr_api_client_id"
    t.index ["ocr_application_id"], name: "index_ocr_application_mappings_on_ocr_application_id"
    t.index ["ocr_application_version_id"], name: "index_ocr_application_mappings_on_ocr_application_version_id"
    t.index ["ocr_pdf_configuration_id"], name: "index_ocr_application_mappings_on_ocr_pdf_configuration_id"
  end

  create_table "ocr_application_versions", force: :cascade do |t|
    t.string "uuid"
    t.string "version", null: false
    t.text "original_pdf"
    t.bigint "ocr_application_id"
    t.bigint "ocr_pdf_configuration_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ocr_application_id"], name: "index_ocr_application_versions_on_ocr_application_id"
    t.index ["ocr_pdf_configuration_id"], name: "index_ocr_application_versions_on_ocr_pdf_configuration_id"
  end

  create_table "ocr_applications", force: :cascade do |t|
    t.string "uuid"
    t.string "title"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.index ["key"], name: "index_ocr_applications_on_key", unique: true
  end

  create_table "ocr_document_types", force: :cascade do |t|
    t.string "uuid"
    t.string "title"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ocr_extractions", force: :cascade do |t|
    t.string "uuid"
    t.text "extraction_response"
    t.xml "xml_response"
    t.string "status"
    t.bigint "ocr_api_client_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ocr_application_version_id"
    t.integer "extraction_status"
    t.jsonb "user_metadata", default: "{}", null: false
    t.text "api_response"
    t.integer "api_status"
    t.string "document_id"
    t.boolean "document_sent"
    t.text "extraction_async_response"
    t.bigint "ocr_application_mapping_id"
    t.index ["ocr_api_client_id"], name: "index_ocr_extractions_on_ocr_api_client_id"
    t.index ["ocr_application_mapping_id"], name: "index_ocr_extractions_on_ocr_application_mapping_id"
    t.index ["ocr_application_version_id"], name: "index_ocr_extractions_on_ocr_application_version_id"
  end

  create_table "ocr_pdf_configurations", force: :cascade do |t|
    t.string "uuid"
    t.string "title"
    t.bigint "ocr_document_type_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ocr_document_type_id"], name: "index_ocr_pdf_configurations_on_ocr_document_type_id"
  end

  create_table "ocr_schema_migrations", primary_key: "version", id: :string, force: :cascade do |t|
    t.datetime "deleted_at", precision: nil
  end

  create_table "qubi_access", id: :integer, default: nil, force: :cascade do |t|
    t.string "accesslist", null: false
    t.integer "dc_company_id", null: false
    t.integer "dc_employee_id", null: false
    t.string "role"
  end

  create_table "qubi_agentquote", id: :integer, default: nil, force: :cascade do |t|
    t.string "business_name", limit: 256
    t.string "phone_number", limit: 256
    t.string "business_email", limit: 256
    t.string "ein", limit: 256
    t.string "ein_detail", limit: 256
    t.string "primry_zipcode", limit: 256
    t.string "worker_comp_datetime", limit: 256
    t.string "carrier_name", limit: 256
    t.string "annual_premium", limit: 256
    t.string "payment_status", limit: 256
    t.string "agentcode", limit: 256
    t.string "curdate", limit: 256
    t.string "transactionseqnumber", limit: 5
    t.string "submissionid", limit: 25
  end

  create_table "qubi_approval_remarks", id: :integer, default: nil, force: :cascade do |t|
    t.integer "approval_id", null: false
    t.string "comments", null: false
    t.integer "commentedby", null: false
    t.date "cdate"
  end

  create_table "qubi_bluewire", primary_key: "dot", id: :integer, default: nil, force: :cascade do |t|
    t.string "status"
    t.string "safety_rating"
    t.integer "power_units"
    t.float "bluewire_gap_score"
    t.float "crash_score"
    t.float "violation_score"
    t.float "csa_basics_score"
    t.float "driver_oos_score"
    t.float "critical_acute"
    t.float "new_entrant_score"
    t.float "mcs150_score"
    t.float "judicial_hellholes"
    t.float "safety_rating_score"
    t.float "driver_count"
  end

  create_table "qubi_bluewire03", primary_key: "dot", id: :integer, default: nil, force: :cascade do |t|
    t.string "status"
    t.string "safety_rating"
    t.integer "power_units"
    t.float "bluewire_gap_score"
    t.float "crash_score"
    t.float "violation_score"
    t.float "csa_basics_score"
    t.float "driver_oos_score"
    t.float "critical_acute"
    t.float "new_entrant_score"
    t.float "mcs150_score"
    t.float "judicial_hellholes"
    t.float "safety_rating_score"
    t.float "driver_count"
  end

  create_table "qubi_cognito", id: :integer, default: nil, force: :cascade do |t|
    t.integer "dc_company_id"
    t.string "provider", null: false
    t.string "name"
    t.string "authority"
    t.string "metadata"
    t.string "audience"
    t.string "clientid", null: false
    t.string "clientsecret", null: false
    t.string "response_type"
    t.string "callback_url"
    t.string "login_url"
    t.string "logout_url"
    t.string "region", null: false
    t.string "user_pool_id", null: false
    t.string "attribute1"
    t.string "attribute2"
    t.string "attribute3"
  end

  create_table "qubi_dynamic_objects", id: :bigint, default: nil, force: :cascade do |t|
    t.string "object_data"
    t.string "object_name"
    t.string "comments"
    t.boolean "onload", default: false, null: false
    t.bigint "cmpid", null: false
    t.date "cdate"
  end

  create_table "qubi_feedback", id: :integer, default: nil, force: :cascade do |t|
    t.string "form_data"
    t.integer "dc_company_id"
    t.integer "dc_employee_id"
    t.string "type"
    t.date "cdate"
    t.boolean "active"
  end

  create_table "qubi_indications", id: :integer, default: nil, force: :cascade do |t|
    t.integer "dc_company_id", null: false
    t.string "code", null: false
    t.string "description", null: false
    t.boolean "ischecked", default: true, null: false
    t.string "icon"
    t.integer "amount", default: 0, null: false
    t.datetime "deleted_at", precision: nil
  end

  create_table "qubi_integrations", id: :integer, default: nil, force: :cascade do |t|
    t.integer "dc_company_id", null: false
    t.string "provider_id", limit: 10, null: false
    t.string "provider_name", null: false
    t.string "domain_url", null: false
    t.string "token_url"
    t.string "session_url"
    t.string "apikey"
    t.string "auth_type"
    t.string "username"
    t.string "passsword"
    t.string "clientid"
    t.string "clientsecret"
    t.string "name"
    t.string "attribute1"
    t.string "attribute2"
    t.string "attribute3"
    t.string "attribute4"
    t.string "api_url"
    t.string "token"
    t.string "session"
    t.datetime "deleted_at", precision: nil
  end

  create_table "qubi_integrations_headers", id: :integer, default: nil, force: :cascade do |t|
    t.integer "integrations_id", null: false
    t.string "header_key", null: false
    t.string "header_value", null: false
    t.string "filter_key"
    t.datetime "deleted_at", precision: nil
  end

  create_table "qubi_master_formio", id: :integer, default: nil, force: :cascade do |t|
    t.string "submissionid", limit: 256, null: false
    t.string "currentdate", limit: 50
    t.string "title", limit: 50
    t.string "userid", limit: 50
    t.string "version", limit: 10
    t.string "formdata", limit: 65535
    t.string "catergory", limit: 25
  end

  create_table "qubi_parameterlist", id: :integer, default: nil, force: :cascade do |t|
    t.string "pname", null: false
    t.string "pdesc", null: false
    t.string "ptype", null: false
    t.integer "cmpid"
    t.integer "empid"
    t.date "cdate", null: false
    t.string "reference"
    t.string "color"
    t.datetime "deleted_at", precision: nil
  end

  create_table "qubi_paymenttransactions", id: :integer, default: nil, force: :cascade do |t|
    t.string "submissionid", limit: 100, null: false
    t.decimal "fee", precision: 6, scale: 2
    t.string "status", limit: 15
    t.string "createuser", limit: 100
    t.string "curdate", limit: 30
    t.integer "quoteid"
    t.string "maskedaccountnumber", limit: 30
    t.string "transactiontype", limit: 50
    t.string "createdatetime", limit: 30
    t.decimal "payerfee", precision: 6, scale: 2
    t.string "emailaddress", limit: 50
    t.string "events", limit: 2000
    t.decimal "amount", precision: 8, scale: 2
    t.string "payer", limit: 100
    t.string "publicid", limit: 25
    t.string "company", limit: 100
    t.string "attachments", limit: 2000
    t.string "comments", limit: 256
    t.string "paidinvoices", limit: 256
    t.string "attributevalues", limit: 256
    t.string "sourceid", limit: 25
  end

  create_table "qubi_submission_approvals", id: :integer, default: nil, force: :cascade do |t|
    t.string "submissionid", null: false
    t.string "action_name"
    t.integer "action_status"
    t.string "action_takenby"
    t.date "action_date"
    t.string "action_comments"
  end

  create_table "qubi_submissions", id: :integer, default: nil, force: :cascade do |t|
    t.string "submissionid", limit: 256, null: false
    t.integer "trxseqnumber", null: false
    t.string "formdata", limit: 65535, null: false
    t.string "createdby", limit: 256, null: false
    t.string "form_name", limit: 256, null: false
    t.string "form_version", limit: 256, null: false
    t.string "company", limit: 256, null: false
    t.string "modifiedby", limit: 256
    t.boolean "isdeleted", default: false
    t.string "display_columns", limit: 65535
    t.string "ref_submissionid", limit: 256
    t.string "ref_attachments", limit: 256
    t.string "status", limit: 256
    t.string "createdt", limit: 30
    t.string "modifieddt", limit: 30
    t.integer "dc_company_id"
    t.string "client_ref_code"
    t.string "client_api_id"
    t.string "client_api_editid"
  end

  create_table "qubi_submissions_ext", id: :integer, default: nil, force: :cascade do |t|
    t.integer "submissions_id", null: false
    t.string "submissionid", null: false
    t.string "form_data"
    t.string "display_columns"
    t.string "reference"
    t.string "attribute1"
    t.string "attribute2"
  end

  create_table "schema_migrations", primary_key: "version", id: :string, force: :cascade do |t|
    t.datetime "deleted_at", precision: nil
  end

  add_foreign_key "app_active_storage_attachments", "app_active_storage_blobs", column: "blob_id"
  add_foreign_key "app_active_storage_variant_records", "app_active_storage_blobs", column: "blob_id"
  add_foreign_key "app_agency_email_preferences", "app_agencies", column: "agency_id"
  add_foreign_key "app_agency_email_preferences", "app_email_preferences", column: "email_preference_id"
  add_foreign_key "app_agency_email_preferences", "dc_companies", column: "company_id"
  add_foreign_key "app_agency_features", "app_agencies", column: "agency_id"
  add_foreign_key "app_agency_features", "app_features", column: "feature_id"
  add_foreign_key "app_agency_features", "dc_companies", column: "company_id"
  add_foreign_key "app_agency_templates", "app_agencies", column: "agency_id", on_delete: :cascade
  add_foreign_key "app_agency_templates", "app_agencies", column: "assigned_by_agency_id"
  add_foreign_key "app_agency_templates", "app_templates", column: "template_id", on_delete: :cascade
  add_foreign_key "app_agency_templates", "dc_companies", column: "company_id"
  add_foreign_key "app_agency_themes", "app_agencies", column: "agency_id", on_delete: :cascade
  add_foreign_key "app_agency_themes", "app_themes", column: "theme_id", on_delete: :cascade
  add_foreign_key "app_agency_themes", "dc_companies", column: "company_id"
  add_foreign_key "app_agent_agencies", "app_agencies", column: "agency_id", on_delete: :cascade
  add_foreign_key "app_agent_agencies", "app_agents", column: "agent_id", on_delete: :cascade
  add_foreign_key "app_agent_features", "app_agents", column: "agent_id"
  add_foreign_key "app_agent_features", "app_features", column: "feature_id"
  add_foreign_key "app_agent_features", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_agent_themes", "app_agency_themes", column: "agency_theme_id", on_delete: :cascade
  add_foreign_key "app_agent_themes", "app_agents", column: "agent_id", on_delete: :cascade
  add_foreign_key "app_agent_themes", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_agents", "app_agencies", column: "agency_id", on_delete: :cascade
  add_foreign_key "app_application_link_documents", "app_application_links", column: "application_link_id"
  add_foreign_key "app_application_link_documents", "app_documents", column: "document_id"
  add_foreign_key "app_application_link_schedule_templates", "app_application_links", column: "application_link_id"
  add_foreign_key "app_application_link_schedule_templates", "app_schedule_templates", column: "schedule_template_id"
  add_foreign_key "app_application_link_templates", "app_application_links", column: "application_link_id", on_delete: :cascade
  add_foreign_key "app_application_link_templates", "app_templates", column: "template_id", on_delete: :cascade
  add_foreign_key "app_application_links", "app_agencies", column: "agency_id", on_delete: :cascade
  add_foreign_key "app_application_links", "app_agents", column: "agent_id", on_delete: :cascade
  add_foreign_key "app_application_links", "dc_companies", column: "company_id", name: "fk_company"
  add_foreign_key "app_application_links", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_derived_submission_groups", "app_submission_groups", column: "base_submission_group_id"
  add_foreign_key "app_derived_submission_groups", "app_submission_groups", column: "received_submission_group_id"
  add_foreign_key "app_derived_submission_groups", "dc_company_connections", on_delete: :cascade
  add_foreign_key "app_digitize_documents", "app_documents", column: "document_id", on_delete: :cascade
  add_foreign_key "app_documents", "app_templates", column: "template_id"
  add_foreign_key "app_documents", "dc_companies", column: "company_id"
  add_foreign_key "app_documents", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_email_discussions", "app_agents", column: "from_agent_id"
  add_foreign_key "app_email_discussions", "app_agents", column: "to_agent_id"
  add_foreign_key "app_email_discussions", "app_submission_groups", column: "submission_group_id"
  add_foreign_key "app_email_discussions", "app_submission_statuses", column: "submission_status_id"
  add_foreign_key "app_email_preferences", "app_email_preference_types", column: "email_preference_type_id"
  add_foreign_key "app_insurance_application_sections", "app_insurance_applications", column: "insurance_application_id", on_delete: :cascade
  add_foreign_key "app_insurance_application_sections", "app_sections", column: "section_id", on_delete: :cascade
  add_foreign_key "app_insurance_applications", "app_agents", column: "agent_id"
  add_foreign_key "app_insurance_applications", "app_application_links", column: "application_link_id"
  add_foreign_key "app_insurance_applications", "app_clients", column: "client_id"
  add_foreign_key "app_insurance_applications", "app_insurance_applications", column: "renewal_parent_id"
  add_foreign_key "app_insurance_applications", "app_submission_groups", column: "submission_group_id"
  add_foreign_key "app_insured_collaborator_sections", "app_insured_collaborators", column: "insured_collaborator_id"
  add_foreign_key "app_insured_collaborator_sections", "app_sections", column: "section_id"
  add_foreign_key "app_insured_collaborator_sections", "dc_companies", column: "account_id"
  add_foreign_key "app_insured_collaborator_sections", "dc_company_employees", column: "company_employee_id", on_delete: :cascade
  add_foreign_key "app_markets", "dc_companies", column: "company_id"
  add_foreign_key "app_outside_email_histories", "app_agents", column: "agent_id"
  add_foreign_key "app_outside_email_histories", "app_insurance_applications", column: "insurance_application_id"
  add_foreign_key "app_outside_email_histories", "app_markets", column: "market_id"
  add_foreign_key "app_outside_email_histories", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_partner_agencies", "app_agencies", column: "agency_id"
  add_foreign_key "app_partner_agencies", "app_partners", column: "partner_id"
  add_foreign_key "app_partner_agencies", "dc_companies", column: "company_id"
  add_foreign_key "app_partner_template_mappings", "app_partners", column: "partner_id"
  add_foreign_key "app_partner_template_mappings", "app_template_mappings", column: "template_mapping_id"
  add_foreign_key "app_pdf_extractions", "app_templates", column: "template_id"
  add_foreign_key "app_pdf_extractions", "dc_companies", column: "company_id"
  add_foreign_key "app_pdf_extractions", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_schedule_templates", "app_agents", column: "agent_id"
  add_foreign_key "app_schedule_templates", "dc_companies", column: "company_id"
  add_foreign_key "app_schedule_templates", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_sections", "app_insurance_applications", column: "insurance_application_id", on_delete: :cascade
  add_foreign_key "app_submission_group_agencies", "app_agencies", column: "agency_id"
  add_foreign_key "app_submission_group_agencies", "app_submission_groups", column: "submission_group_id"
  add_foreign_key "app_submission_group_agencies", "dc_companies", column: "company_id"
  add_foreign_key "app_submission_group_agents", "app_agents", column: "agent_id"
  add_foreign_key "app_submission_group_agents", "app_submission_groups", column: "submission_group_id"
  add_foreign_key "app_submission_group_agents", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_submission_group_documents", "app_documents", column: "document_id"
  add_foreign_key "app_submission_group_documents", "app_submission_groups", column: "submission_group_id"
  add_foreign_key "app_submission_group_notes", "app_submission_groups", column: "submission_group_id"
  add_foreign_key "app_submission_group_schedule_templates", "app_schedule_templates", column: "schedule_template_id"
  add_foreign_key "app_submission_group_schedule_templates", "app_submission_groups", column: "submission_group_id"
  add_foreign_key "app_submission_group_schedules", "app_submission_group_schedule_templates"
  add_foreign_key "app_submission_groups", "app_agencies", column: "agency_id"
  add_foreign_key "app_submission_groups", "app_agents", column: "agent_id"
  add_foreign_key "app_submission_groups", "app_clients", column: "client_id"
  add_foreign_key "app_submission_groups", "app_submission_statuses", column: "status_id"
  add_foreign_key "app_submission_groups", "dc_companies", column: "account_id"
  add_foreign_key "app_submission_groups", "dc_companies", column: "company_id"
  add_foreign_key "app_submission_groups", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "app_templates", "app_templates", column: "renewal_template_id"
  add_foreign_key "dc_authentication_codes", "dc_company_employees", column: "company_employee_id"
  add_foreign_key "dc_companies", "dc_company_types", column: "comp_type_id", name: "dc_companies_dc_company_type_id_fkey"
  add_foreign_key "dc_company_connections", "dc_companies", column: "dc_partner_company_id", name: "dc_company_connections_dc_partner_company_id_fkey"
  add_foreign_key "dc_company_connections", "dc_companies", name: "dc_company_connections_dc_company_id_fkey"
  add_foreign_key "dc_company_employees", "dc_companies", name: "dc_company_employees_dc_company_id_fkey"
  add_foreign_key "dc_company_employees", "dc_employees", name: "dc_company_employees_dc_employee_id_fkey"
  add_foreign_key "dc_roles", "dc_company_types", column: "comp_type_id", name: "comp_type_id_fk", validate: false
  add_foreign_key "nav_active_storage_attachments", "nav_active_storage_blobs", column: "blob_id"
  add_foreign_key "nav_active_storage_variant_records", "nav_active_storage_blobs", column: "blob_id"
  add_foreign_key "nav_activities", "dc_companies", on_delete: :cascade
  add_foreign_key "nav_activities", "dc_company_employees"
  add_foreign_key "nav_activity_actions", "nav_actions", on_delete: :cascade
  add_foreign_key "nav_activity_actions", "nav_activities", on_delete: :cascade
  add_foreign_key "nav_activity_triggers", "nav_activities", on_delete: :cascade
  add_foreign_key "nav_activity_triggers", "nav_questionnaires", on_delete: :cascade
  add_foreign_key "nav_assessment_action_result_triggers", "nav_activity_triggers", column: "activity_trigger_id", on_delete: :cascade
  add_foreign_key "nav_assessment_action_result_triggers", "nav_assessment_action_results", column: "assessment_action_result_id", on_delete: :cascade
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
  add_foreign_key "ocr_active_storage_attachments", "ocr_active_storage_blobs", column: "blob_id"
  add_foreign_key "ocr_active_storage_variant_records", "ocr_active_storage_blobs", column: "blob_id"
  add_foreign_key "ocr_application_mappings", "ocr_api_clients"
  add_foreign_key "ocr_application_mappings", "ocr_application_versions"
  add_foreign_key "ocr_application_mappings", "ocr_applications"
  add_foreign_key "ocr_application_mappings", "ocr_pdf_configurations"
  add_foreign_key "ocr_application_versions", "ocr_applications"
  add_foreign_key "ocr_application_versions", "ocr_pdf_configurations"
  add_foreign_key "ocr_extractions", "ocr_api_clients"
  add_foreign_key "ocr_extractions", "ocr_application_mappings"
  add_foreign_key "ocr_extractions", "ocr_application_versions"
  add_foreign_key "ocr_pdf_configurations", "ocr_document_types"
  add_foreign_key "qubi_indications", "dc_companies", column: "id", name: "dc_company_id"
  add_foreign_key "qubi_integrations", "dc_companies", name: "fk_dc_company_id", validate: false
  add_foreign_key "qubi_integrations_headers", "qubi_integrations", column: "integrations_id", name: "fk_integrations_headers_id", validate: false
end
