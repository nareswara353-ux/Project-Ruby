class DiscussionPost < ApplicationRecord
  belongs_to :discussion_topic
  belongs_to :user
  belongs_to :parent, class_name: "DiscussionPost", optional: true
  has_many :replies, class_name: "DiscussionPost", foreign_key: :parent_id, dependent: :destroy

  validates :content, presence: true, length: { maximum: 2000 }

  scope :root_posts, -> { where(parent_id: nil) }
  scope :ordered, -> { order(created_at: :asc) }

  after_create :increment_topic_posts_count
  after_destroy :decrement_topic_posts_count

  private

  def increment_topic_posts_count
    discussion_topic.increment!(:posts_count)
  end

  def decrement_topic_posts_count
    discussion_topic.decrement!(:posts_count)
  end
end
