class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :content, null: false
      t.integer :question_type, null: false, default: 0
      t.string :option_a
      t.string :option_b
      t.string :option_c
      t.string :option_d
      t.string :correct_answer
      t.text :explanation
      t.integer :difficulty, default: 0
      t.string :category

      t.timestamps
    end

    add_index :questions, :question_type
    add_index :questions, :difficulty
    add_index :questions, :category
  end
end
