class CreateQuizQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :position, null: false, default: 0
      t.integer :points, null: false, default: 1

      t.timestamps
    end

    add_index :quiz_questions, [:quiz_id, :position], unique: true
    add_index :quiz_questions, [:quiz_id, :question_id], unique: true
  end
end
