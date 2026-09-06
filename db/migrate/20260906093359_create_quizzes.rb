class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.references :course, null: false, foreign_key: true
      t.references :lesson, null: true, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :time_limit, default: 0
      t.integer :passing_score, default: 70
      t.integer :status, null: false, default: 0
      t.integer :questions_count, default: 0

      t.timestamps
    end

    add_index :quizzes, [:course_id, :status]
    add_index :quizzes, [:lesson_id, :status]
  end
end
