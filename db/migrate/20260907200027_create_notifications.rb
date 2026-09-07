class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, polymorphic: true, null: false
      t.string :message, null: false
      t.string :url
      t.boolean :read, default: false
      t.references :notifiable, polymorphic: true

      t.timestamps
    end

    add_index :notifications, [:recipient_type, :recipient_id, :read]
    add_index :notifications, :created_at
  end
end
