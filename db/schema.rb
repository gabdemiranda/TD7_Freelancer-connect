# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_211_017_211_829) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'freelancer_feedbacks', force: :cascade do |t|
    t.string 'feedback'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'proposal_id', null: false
    t.index ['proposal_id'], name: 'index_freelancer_feedbacks_on_proposal_id'
  end

  create_table 'freelancer_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_freelancer_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_freelancer_users_on_reset_password_token', unique: true
  end

  create_table 'profiles', force: :cascade do |t|
    t.string 'fullname'
    t.string 'socialname'
    t.date 'birthdate'
    t.string 'education'
    t.string 'description'
    t.string 'experience'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'freelancer_user_id', null: false
    t.index ['freelancer_user_id'], name: 'index_profiles_on_freelancer_user_id'
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.string 'skills'
    t.decimal 'value'
    t.date 'end_date'
    t.string 'work_style'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'regular_user_id', null: false
    t.integer 'status', default: 5
    t.index ['regular_user_id'], name: 'index_projects_on_regular_user_id'
  end

  create_table 'proposals', force: :cascade do |t|
    t.string 'reason'
    t.decimal 'value'
    t.integer 'available_time'
    t.date 'expected_end'
    t.integer 'project_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'freelancer_user_id', null: false
    t.integer 'status', default: 5
    t.index ['freelancer_user_id'], name: 'index_proposals_on_freelancer_user_id'
    t.index ['project_id'], name: 'index_proposals_on_project_id'
  end

  create_table 'regular_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_regular_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_regular_users_on_reset_password_token', unique: true
  end

  create_table 'views', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_views_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_views_on_reset_password_token', unique: true
  end

  add_foreign_key 'freelancer_feedbacks', 'proposals'
  add_foreign_key 'profiles', 'freelancer_users'
  add_foreign_key 'projects', 'regular_users'
  add_foreign_key 'proposals', 'freelancer_users'
  add_foreign_key 'proposals', 'projects'
end
