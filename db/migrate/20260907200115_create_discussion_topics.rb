class CreateDiscussionTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :discussion_topics do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.integer :status, null: false, default: 0
      t.boolean :pinned, default: false
      t.integer :posts_count, default: 0

      t.timestamps
    end

    add_index :discussion_topics, [:course_id, :status]
    add_index :discussion_topics, :pinned
  end
end
