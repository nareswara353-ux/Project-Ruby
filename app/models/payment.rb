class Payment < ApplicationRecord
  enum status: { pending: 0, successful: 1, failed: 2, refunded: 3 }

  belongs_to :user
  belongs_to :course

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true, length: { is: 3 }
  validates :stripe_payment_intent_id, uniqueness: true, allow_nil: true

  scope :successful, -> { where(status: :successful) }
  scope :recent, -> { order(created_at: :desc) }

  def mark_successful!
    update(status: :successful)
    Enrollment.create!(user: user, course: course, status: :active)
  end

  def mark_failed!
    update(status: :failed)
  end

  def refund!
    update(status: :refunded)
  end
end
