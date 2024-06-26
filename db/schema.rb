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

ActiveRecord::Schema[7.0].define(version: 2023_10_18_054027) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assessments_answers", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "attempt_id", null: false
    t.bigint "question_id", null: false
    t.jsonb "content"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_assessments_answers_on_attempt_id"
    t.index ["organization_id"], name: "index_assessments_answers_on_organization_id"
    t.index ["question_id"], name: "index_assessments_answers_on_question_id"
  end

  create_table "assessments_assessments", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "node_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_assessments_assessments_on_node_id"
    t.index ["organization_id"], name: "index_assessments_assessments_on_organization_id"
  end

  create_table "assessments_attempts", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "assessment_id", null: false
    t.bigint "user_id"
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_assessments_attempts_on_assessment_id"
    t.index ["organization_id"], name: "index_assessments_attempts_on_organization_id"
    t.index ["user_id"], name: "index_assessments_attempts_on_user_id"
  end

  create_table "assessments_questions", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "assessment_id", null: false
    t.string "type", default: "Assessments::Questions::Text"
    t.string "content"
    t.integer "position"
    t.jsonb "answer_options", default: []
    t.jsonb "correct_answer"
    t.integer "weight", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_assessments_questions_on_assessment_id"
    t.index ["organization_id"], name: "index_assessments_questions_on_organization_id"
  end

  create_table "edges", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "source_id", null: false
    t.bigint "target_id", null: false
    t.string "source_handle"
    t.string "target_handle"
    t.string "label"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_edges_on_organization_id"
    t.index ["source_id"], name: "index_edges_on_source_id"
    t.index ["target_id"], name: "index_edges_on_target_id"
  end

  create_table "maintainers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.bigint "roadmap_id", null: false
    t.boolean "is_creator", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_maintainers_on_organization_id"
    t.index ["roadmap_id"], name: "index_maintainers_on_roadmap_id"
    t.index ["user_id"], name: "index_maintainers_on_user_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_members_on_organization_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "roadmap_id", null: false
    t.string "type"
    t.jsonb "position", default: {}
    t.string "title"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_nodes_on_organization_id"
    t.index ["roadmap_id"], name: "index_nodes_on_roadmap_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roadmaps", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "organization_id", null: false
    t.string "slug", null: false
    t.jsonb "ui_settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_roadmaps_on_organization_id"
    t.index ["slug"], name: "index_roadmaps_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assessments_answers", "assessments_attempts", column: "attempt_id"
  add_foreign_key "assessments_answers", "assessments_questions", column: "question_id"
  add_foreign_key "assessments_answers", "organizations"
  add_foreign_key "assessments_assessments", "nodes"
  add_foreign_key "assessments_assessments", "organizations"
  add_foreign_key "assessments_attempts", "assessments_assessments", column: "assessment_id"
  add_foreign_key "assessments_attempts", "organizations"
  add_foreign_key "assessments_questions", "assessments_assessments", column: "assessment_id"
  add_foreign_key "assessments_questions", "organizations"
  add_foreign_key "edges", "nodes", column: "source_id"
  add_foreign_key "edges", "nodes", column: "target_id"
  add_foreign_key "edges", "organizations"
  add_foreign_key "maintainers", "organizations"
  add_foreign_key "maintainers", "roadmaps"
  add_foreign_key "maintainers", "users"
  add_foreign_key "members", "organizations"
  add_foreign_key "members", "users"
  add_foreign_key "nodes", "organizations"
  add_foreign_key "nodes", "roadmaps"
  add_foreign_key "roadmaps", "organizations"
end
