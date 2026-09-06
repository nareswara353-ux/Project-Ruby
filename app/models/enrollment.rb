class Enrollment < ApplicationRecord
  enum status: { active: 0, completed: 1, dropped: 2 }

  belongs_to :user
  belongs_to :course

  validates :user_id, uniqueness: { scope: :course_id }
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  before_validation :set_enrolled_at, on: :create

  scope :active, -> { where(status: :active) }
  scope :completed, -> { where(status: :completed) }

  def complete!
    update(status: :completed, completed_at: Time.current, progress: 100)
  end

  def update_progress!
    total = course.total_lessons_count
    return if total.zero?
    completed = lesson_completions_count
    update(progress: (completed.to_f / total * 100).to_i)
  end

  private

  def set_enrolled_at
    self.enrolled_at = Time.current
  end

  def lesson_completions_count
    LessonCompletion.where(user: user, lesson: course.lessons.published).count
  end
end
