# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "picture",    :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_service"
  end

  create_table "contacts", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "function"
    t.string   "email"
    t.text     "address"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "picture",    :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "firstname",  :limit => 100
    t.string   "lastname"
    t.string   "company"
    t.string   "function"
    t.string   "email"
    t.text     "address"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "phone1"
    t.string   "phone2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "title",       :limit => 100
    t.text     "description"
    t.decimal  "price",                      :precision => 11, :scale => 4
    t.string   "picture",     :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
