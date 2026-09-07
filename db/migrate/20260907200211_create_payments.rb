class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :currency, null: false, default: "usd"
      t.string :stripe_payment_intent_id
      t.string :stripe_customer_id
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_index :payments, :stripe_payment_intent_id, unique: true
    add_index :payments, [:user_id, :status]
    add_index :payments, [:course_id, :status]
  end
end
