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

ActiveRecord::Schema.define(version: 20150106124541) do

  create_table "consumers", force: true do |t|
    t.integer  "customer_id", null: false
    t.string   "name",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "upload_id",                                             null: false
    t.integer  "tag_id",                                                null: false
    t.integer  "external_id",                                           null: false
    t.integer  "graydon_id",                                            null: false
    t.string   "graydon_name",                                          null: false
    t.decimal  "reliability",  precision: 10, scale: 0,                 null: false
    t.boolean  "matched",                               default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["tag_id", "graydon_id", "matched"], name: "index_matches_on_tag_id_and_graydon_id_and_matched", using: :btree

  create_table "organizations", force: true do |t|
    t.integer  "customer_id", null: false
    t.integer  "consumer_id", null: false
    t.integer  "graydon_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["graydon_id", "consumer_id"], name: "index_organizations_on_graydon_id_and_consumer_id", unique: true, using: :btree

  create_table "organizations_tags", force: true do |t|
    t.integer "organization_id", null: false
    t.integer "tag_id",          null: false
  end

  add_index "organizations_tags", ["organization_id", "tag_id"], name: "index_organizations_tags_on_organization_id_and_tag_id", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",        null: false
    t.string   "nature",      null: false
    t.integer  "customer_id"
    t.integer  "consumer_id"
    t.integer  "parent_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["consumer_id", "name"], name: "index_tags_on_consumer_id_and_name", unique: true, using: :btree

  create_table "uploads", force: true do |t|
    t.integer  "customer_id", null: false
    t.integer  "consumer_id", null: false
    t.integer  "tag_id",      null: false
    t.integer  "user_id",     null: false
    t.string   "claim_check", null: false
    t.string   "upload_type", null: false
    t.string   "status",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "customer_id", null: false
    t.integer  "consumer_id", null: false
    t.string   "name",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
