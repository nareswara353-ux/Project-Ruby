class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.references :instructor, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :description
      t.decimal :price, precision: 8, scale: 2, default: 0.0
      t.integer :status, null: false, default: 0
      t.integer :level, null: false, default: 0
      t.integer :duration, default: 0
      t.string :slug, null: false
      t.string :cover_image

      t.timestamps
    end

    add_index :courses, :slug, unique: true
    add_index :courses, [:instructor_id, :status]
  end
end
