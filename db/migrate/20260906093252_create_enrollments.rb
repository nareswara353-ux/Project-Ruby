class CreateEnrollments < ActiveRecord::Migration[7.1]
  def change
    create_table :enrollments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :progress, default: 0
      t.datetime :enrolled_at, null: false
      t.datetime :completed_at

      t.timestamps
    end

    add_index :enrollments, [:user_id, :course_id], unique: true
    add_index :enrollments, [:course_id, :status]
    add_index :enrollments, [:user_id, :status]
  end
end
