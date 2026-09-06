class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.references :course_module, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :video_url
      t.integer :duration, default: 0
      t.integer :position, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :lesson_type, null: false, default: 0
      t.string :slug

      t.timestamps
    end

    add_index :lessons, [:course_module_id, :position], unique: true
    add_index :lessons, :slug, unique: true
    add_index :lessons, [:course_module_id, :status]
  end
end
