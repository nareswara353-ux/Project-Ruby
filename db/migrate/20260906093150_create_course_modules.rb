class CreateCourseModules < ActiveRecord::Migration[7.1]
  def change
    create_table :course_modules do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :position, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :lessons_count, default: 0

      t.timestamps
    end

    add_index :course_modules, [:course_id, :position], unique: true
    add_index :course_modules, [:course_id, :status]
  end
end
