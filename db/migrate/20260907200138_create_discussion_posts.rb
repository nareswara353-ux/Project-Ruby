class CreateDiscussionPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :discussion_posts do |t|
      t.references :discussion_topic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :parent, null: true, foreign_key: { to_table: :discussion_posts }
      t.text :content, null: false

      t.timestamps
    end

    add_index :discussion_posts, [:discussion_topic_id, :created_at]
  end
end
