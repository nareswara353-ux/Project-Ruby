class QuizSubmissionPolicy < ApplicationPolicy
  def show?
    admin? || owner? || instructor_of_course?
  end

  def create?
    user&.student?
  end

  def update?
    owner? && record.in_progress?
  end

  def grade?
    admin? || instructor_of_course?
  end

  private

  def owner?
    user.present? && record.user_id == user.id
  end

  def instructor_of_course?
    user&.instructor? && record.quiz.course.instructor_id == user.id
  end

  def admin?
    user&.admin?
  end
end
