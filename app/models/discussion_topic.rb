class DiscussionTopic < ApplicationRecord
  enum status: { open: 0, closed: 1 }

  belongs_to :course
  belongs_to :user
  has_many :posts, class_name: "DiscussionPost", dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }
  validates :content, presence: true, length: { maximum: 2000 }

  scope :pinned_first, -> { order(pinned: :desc, created_at: :desc) }
  scope :active, -> { where(status: :open) }

  def close!
    update(status: :closed)
  end

  def reopen!
    update(status: :open)
  end
end
