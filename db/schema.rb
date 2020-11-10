# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_22_151225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_enum :department_module_users_roles, [
    "responsible",
    "collaborator",
  ], force: :cascade

  create_enum :department_users_roles, [
    "responsible",
    "collaborator",
  ], force: :cascade

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_enum :document_categories, [
    "declaration",
    "certification",
  ], force: :cascade

  create_table "audience_members", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "cpf", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cpf"], name: "index_audience_members_on_cpf", unique: true
    t.index ["email"], name: "index_audience_members_on_email", unique: true
  end

  create_table "department_module_users", force: :cascade do |t|
    t.bigint "department_module_id", null: false
    t.bigint "user_id", null: false
    t.enum "role", enum_name: "department_module_users_roles"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_module_id", "user_id"], name: "module_users", unique: true
    t.index ["department_module_id"], name: "index_department_module_users_on_department_module_id"
    t.index ["role"], name: "index_department_module_users_on_role"
    t.index ["user_id"], name: "index_department_module_users_on_user_id"
  end

  create_table "department_modules", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_department_modules_on_department_id"
    t.index ["name"], name: "index_department_modules_on_name", unique: true
  end

  create_table "department_users", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.bigint "user_id", null: false
    t.enum "role", enum_name: "department_users_roles"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id", "user_id"], name: "index_department_users_on_department_id_and_user_id", unique: true
    t.index ["department_id"], name: "index_department_users_on_department_id"
    t.index ["role"], name: "index_department_users_on_role"
    t.index ["user_id"], name: "index_department_users_on_user_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "initials"
    t.string "local"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_departments_on_email", unique: true
    t.index ["initials"], name: "index_departments_on_initials", unique: true
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.enum "category", enum_name: "document_categories"
    t.string "title", null: false
    t.text "front_text"
    t.text "back_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_documents_on_category"
    t.index ["department_id"], name: "index_documents_on_department_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_roles_on_identifier", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "username"
    t.string "register_number"
    t.string "cpf"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar"
    t.bigint "role_id"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "department_module_users", "department_modules"
  add_foreign_key "department_module_users", "users"
  add_foreign_key "department_modules", "departments"
  add_foreign_key "department_users", "departments"
  add_foreign_key "department_users", "users"
  add_foreign_key "documents", "departments"
  add_foreign_key "users", "roles"
end
