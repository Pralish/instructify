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

ActiveRecord::Schema[7.0].define(version: 2023_08_17_153901) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connections", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "from_node_id", null: false
    t.bigint "to_node_id", null: false
    t.string "from_output"
    t.string "to_input"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_node_id"], name: "index_connections_on_from_node_id"
    t.index ["organization_id"], name: "index_connections_on_organization_id"
    t.index ["to_node_id"], name: "index_connections_on_to_node_id"
  end

  create_table "editors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.bigint "roadmap_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_editors_on_organization_id"
    t.index ["roadmap_id"], name: "index_editors_on_roadmap_id"
    t.index ["user_id"], name: "index_editors_on_user_id"
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
    t.string "content_type", null: false
    t.bigint "content_id", null: false
    t.string "pos_x"
    t.string "pos_y"
    t.string "class_name"
    t.boolean "typenode", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_type", "content_id"], name: "index_nodes_on_content"
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
    t.string "title"
    t.text "description"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_roadmaps_on_organization_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "roadmap_id", null: false
    t.bigint "organization_id", null: false
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_steps_on_ancestry"
    t.index ["organization_id"], name: "index_steps_on_organization_id"
    t.index ["roadmap_id"], name: "index_steps_on_roadmap_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "step_id", null: false
    t.bigint "organization_id", null: false
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_tasks_on_ancestry"
    t.index ["organization_id"], name: "index_tasks_on_organization_id"
    t.index ["step_id"], name: "index_tasks_on_step_id"
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

  add_foreign_key "connections", "nodes", column: "from_node_id"
  add_foreign_key "connections", "nodes", column: "to_node_id"
  add_foreign_key "connections", "organizations"
  add_foreign_key "editors", "organizations"
  add_foreign_key "editors", "roadmaps"
  add_foreign_key "editors", "users"
  add_foreign_key "members", "organizations"
  add_foreign_key "members", "users"
  add_foreign_key "nodes", "organizations"
  add_foreign_key "nodes", "roadmaps"
  add_foreign_key "roadmaps", "organizations"
  add_foreign_key "steps", "organizations"
  add_foreign_key "steps", "roadmaps"
  add_foreign_key "tasks", "organizations"
  add_foreign_key "tasks", "steps"
end
