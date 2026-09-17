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

ActiveRecord::Schema[8.1].define(version: 2026_09_07_200241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "certificates", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.datetime "issued_at", null: false
    t.string "pdf_url"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["code"], name: "index_certificates_on_code", unique: true
    t.index ["course_id"], name: "index_certificates_on_course_id"
    t.index ["user_id", "course_id"], name: "index_certificates_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_certificates_on_user_id"
  end

  create_table "course_modules", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "lessons_count", default: 0
    t.integer "position", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "position"], name: "index_course_modules_on_course_id_and_position", unique: true
    t.index ["course_id", "status"], name: "index_course_modules_on_course_id_and_status"
    t.index ["course_id"], name: "index_course_modules_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "cover_image"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "duration", default: 0
    t.bigint "instructor_id", null: false
    t.integer "level", default: 0, null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0"
    t.string "slug", null: false
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id", "status"], name: "index_courses_on_instructor_id_and_status"
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
  end

  create_table "discussion_posts", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.bigint "discussion_topic_id", null: false
    t.bigint "parent_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["discussion_topic_id", "created_at"], name: "index_discussion_posts_on_discussion_topic_id_and_created_at"
    t.index ["discussion_topic_id"], name: "index_discussion_posts_on_discussion_topic_id"
    t.index ["parent_id"], name: "index_discussion_posts_on_parent_id"
    t.index ["user_id"], name: "index_discussion_posts_on_user_id"
  end

  create_table "discussion_topics", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.boolean "pinned", default: false
    t.integer "posts_count", default: 0
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["course_id", "status"], name: "index_discussion_topics_on_course_id_and_status"
    t.index ["course_id"], name: "index_discussion_topics_on_course_id"
    t.index ["pinned"], name: "index_discussion_topics_on_pinned"
    t.index ["user_id"], name: "index_discussion_topics_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.datetime "completed_at"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "enrolled_at", null: false
    t.integer "progress", default: 0
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["course_id", "status"], name: "index_enrollments_on_course_id_and_status"
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id", "course_id"], name: "index_enrollments_on_user_id_and_course_id", unique: true
    t.index ["user_id", "status"], name: "index_enrollments_on_user_id_and_status"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "lesson_completions", force: :cascade do |t|
    t.datetime "completed_at", null: false
    t.datetime "created_at", null: false
    t.bigint "lesson_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["lesson_id"], name: "index_lesson_completions_on_lesson_id"
    t.index ["user_id", "completed_at"], name: "index_lesson_completions_on_user_id_and_completed_at"
    t.index ["user_id", "lesson_id"], name: "index_lesson_completions_on_user_id_and_lesson_id", unique: true
    t.index ["user_id"], name: "index_lesson_completions_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.text "content"
    t.bigint "course_module_id", null: false
    t.datetime "created_at", null: false
    t.integer "duration", default: 0
    t.integer "lesson_type", default: 0, null: false
    t.integer "position", default: 0, null: false
    t.string "slug"
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.string "video_url"
    t.index ["course_module_id", "position"], name: "index_lessons_on_course_module_id_and_position", unique: true
    t.index ["course_module_id", "status"], name: "index_lessons_on_course_module_id_and_status"
    t.index ["course_module_id"], name: "index_lessons_on_course_module_id"
    t.index ["slug"], name: "index_lessons_on_slug", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "message", null: false
    t.bigint "notifiable_id"
    t.string "notifiable_type"
    t.boolean "read", default: false
    t.bigint "recipient_id", null: false
    t.string "recipient_type", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["created_at"], name: "index_notifications_on_created_at"
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["recipient_type", "recipient_id", "read"], name: "idx_on_recipient_type_recipient_id_read_8e7ebd1b55"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.string "currency", default: "usd", null: false
    t.jsonb "metadata", default: {}
    t.integer "status", default: 0, null: false
    t.string "stripe_customer_id"
    t.string "stripe_payment_intent_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["course_id", "status"], name: "index_payments_on_course_id_and_status"
    t.index ["course_id"], name: "index_payments_on_course_id"
    t.index ["stripe_payment_intent_id"], name: "index_payments_on_stripe_payment_intent_id", unique: true
    t.index ["user_id", "status"], name: "index_payments_on_user_id_and_status"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "category"
    t.text "content", null: false
    t.string "correct_answer"
    t.datetime "created_at", null: false
    t.integer "difficulty", default: 0
    t.text "explanation"
    t.string "option_a"
    t.string "option_b"
    t.string "option_c"
    t.string "option_d"
    t.integer "question_type", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_questions_on_category"
    t.index ["difficulty"], name: "index_questions_on_difficulty"
    t.index ["question_type"], name: "index_questions_on_question_type"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "points", default: 1, null: false
    t.integer "position", default: 0, null: false
    t.bigint "question_id", null: false
    t.bigint "quiz_id", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_quiz_questions_on_question_id"
    t.index ["quiz_id", "position"], name: "index_quiz_questions_on_quiz_id_and_position", unique: true
    t.index ["quiz_id", "question_id"], name: "index_quiz_questions_on_quiz_id_and_question_id", unique: true
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
  end

  create_table "quiz_submissions", force: :cascade do |t|
    t.jsonb "answers", default: {}
    t.datetime "created_at", null: false
    t.bigint "quiz_id", null: false
    t.integer "score"
    t.datetime "started_at"
    t.integer "status", default: 0, null: false
    t.datetime "submitted_at"
    t.integer "time_taken"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["quiz_id"], name: "index_quiz_submissions_on_quiz_id"
    t.index ["status"], name: "index_quiz_submissions_on_status"
    t.index ["user_id", "quiz_id"], name: "index_quiz_submissions_on_user_id_and_quiz_id", unique: true, where: "(status = 0)"
    t.index ["user_id"], name: "index_quiz_submissions_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "lesson_id"
    t.integer "passing_score", default: 70
    t.integer "questions_count", default: 0
    t.integer "status", default: 0, null: false
    t.integer "time_limit", default: 0
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "status"], name: "index_quizzes_on_course_id_and_status"
    t.index ["course_id"], name: "index_quizzes_on_course_id"
    t.index ["lesson_id", "status"], name: "index_quizzes_on_lesson_id_and_status"
    t.index ["lesson_id"], name: "index_quizzes_on_lesson_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar"
    t.text "bio"
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "locked_at"
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 2, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "certificates", "courses"
  add_foreign_key "certificates", "users"
  add_foreign_key "course_modules", "courses"
  add_foreign_key "courses", "users", column: "instructor_id"
  add_foreign_key "discussion_posts", "discussion_posts", column: "parent_id"
  add_foreign_key "discussion_posts", "discussion_topics"
  add_foreign_key "discussion_posts", "users"
  add_foreign_key "discussion_topics", "courses"
  add_foreign_key "discussion_topics", "users"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "lesson_completions", "lessons"
  add_foreign_key "lesson_completions", "users"
  add_foreign_key "lessons", "course_modules"
  add_foreign_key "payments", "courses"
  add_foreign_key "payments", "users"
  add_foreign_key "quiz_questions", "questions"
  add_foreign_key "quiz_questions", "quizzes"
  add_foreign_key "quiz_submissions", "quizzes"
  add_foreign_key "quiz_submissions", "users"
  add_foreign_key "quizzes", "courses"
  add_foreign_key "quizzes", "lessons"
end
