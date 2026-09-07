class CreateQuizSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true
      t.jsonb :answers, default: {}
      t.integer :score
      t.integer :status, null: false, default: 0
      t.datetime :started_at
      t.datetime :submitted_at
      t.integer :time_taken

      t.timestamps
    end

    add_index :quiz_submissions, [:user_id, :quiz_id], unique: true, where: "status = 0"
    add_index :quiz_submissions, :status
  end
end
