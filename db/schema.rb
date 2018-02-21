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

ActiveRecord::Schema.define(version: 20180215211249) do

  create_table "js_data", force: :cascade do |t|
    t.string   "Vorhaben"
    t.string   "Serie"
    t.string   "P_Relevanz"
    t.string   "Uebergabe_in_die_Montage"
    t.string   "Fahrgestellnummer"
    t.string   "Day"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "Vorhaben"
    t.string   "P_Status"
    t.text     "SET"
    t.string   "Sachbearbeiter"
    t.string   "P_Relevanz"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "P_Statusdatum"
    t.string   "Serie"
    t.string   "Uebergabe_in_die_Montage"
    t.string   "Fahrgestellnummer"
    t.string   "Denominacion"
  end

  create_table "shopfloors", force: :cascade do |t|
    t.string   "Vorhaben"
    t.string   "P_Status"
    t.string   "P_Statusdatum"
    t.string   "Tech_Unterlagen"
    t.string   "P_Relevanz"
    t.string   "Einsatzart"
    t.string   "BEMI"
    t.string   "PV"
    t.string   "Serie"
    t.string   "Fahrgestellnummer"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
