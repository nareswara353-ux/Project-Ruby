class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true
  belongs_to :notifiable, polymorphic: true, optional: true

  validates :message, presence: true, length: { maximum: 500 }

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }
  scope :recent, -> { order(created_at: :desc).limit(50) }

  def mark_as_read!
    update(read: true)
  end

  def mark_as_unread!
    update(read: false)
  end
end
