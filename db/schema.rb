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

ActiveRecord::Schema.define(version: 2023_10_17_124742) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cookeries", force: :cascade do |t|
    t.integer "recipe_id"
    t.text "process", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_cookeries_on_recipe_id"
  end

  create_table "effect_tags", force: :cascade do |t|
    t.integer "nutrient_id", null: false
    t.integer "effect_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["effect_id"], name: "index_effect_tags_on_effect_id"
    t.index ["nutrient_id"], name: "index_effect_tags_on_nutrient_id"
  end

  create_table "effects", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer "recipe_id"
    t.string "content", null: false
    t.string "quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "made_lists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_made_lists_on_recipe_id"
    t.index ["user_id", "recipe_id"], name: "index_made_lists_on_user_id_and_recipe_id", unique: true
    t.index ["user_id"], name: "index_made_lists_on_user_id"
  end

  create_table "myrecipes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_myrecipes_on_recipe_id"
    t.index ["user_id"], name: "index_myrecipes_on_user_id"
  end

  create_table "nutrient_tags", force: :cascade do |t|
    t.integer "vegetable_id", null: false
    t.integer "nutrient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nutrient_id"], name: "index_nutrient_tags_on_nutrient_id"
    t.index ["vegetable_id"], name: "index_nutrient_tags_on_vegetable_id"
  end

  create_table "nutrients", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.string "summary", null: false
    t.text "introduction", null: false
    t.integer "time", null: false
    t.integer "difficulty", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.text "content", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "star", null: false
    t.text "comment"
    t.integer "user_id", null: false
    t.integer "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_reviews_on_recipe_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tag_relations", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_tag_relations_on_recipe_id"
    t.index ["tag_id"], name: "index_tag_relations_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "account_name", null: false
    t.string "telephone_number", null: false
    t.string "birth_date", null: false
    t.string "gender", null: false
    t.boolean "is_active", default: true
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vegetable_tags", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "vegetable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_vegetable_tags_on_recipe_id"
    t.index ["vegetable_id"], name: "index_vegetable_tags_on_vegetable_id"
  end

  create_table "vegetables", force: :cascade do |t|
    t.string "name", null: false
    t.string "seasonal", null: false
    t.text "production_area", null: false
    t.text "keeping", null: false
    t.text "introduction", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "want_to_make_lists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_want_to_make_lists_on_recipe_id"
    t.index ["user_id", "recipe_id"], name: "index_want_to_make_lists_on_user_id_and_recipe_id", unique: true
    t.index ["user_id"], name: "index_want_to_make_lists_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cookeries", "recipes"
  add_foreign_key "effect_tags", "effects"
  add_foreign_key "effect_tags", "nutrients"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "made_lists", "recipes"
  add_foreign_key "made_lists", "users"
  add_foreign_key "myrecipes", "recipes"
  add_foreign_key "myrecipes", "users"
  add_foreign_key "nutrient_tags", "nutrients"
  add_foreign_key "nutrient_tags", "vegetables"
  add_foreign_key "recipes", "users"
  add_foreign_key "requests", "users"
  add_foreign_key "reviews", "recipes"
  add_foreign_key "reviews", "users"
  add_foreign_key "tag_relations", "recipes"
  add_foreign_key "tag_relations", "tags"
  add_foreign_key "vegetable_tags", "recipes"
  add_foreign_key "vegetable_tags", "vegetables"
  add_foreign_key "want_to_make_lists", "recipes"
  add_foreign_key "want_to_make_lists", "users"
end
