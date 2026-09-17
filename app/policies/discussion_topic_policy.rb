class DiscussionTopicPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    admin? || owner? || instructor_of_course?
  end

  def destroy?
    admin? || owner? || instructor_of_course?
  end

  private

  def owner?
    user.present? && record.user_id == user.id
  end

  def instructor_of_course?
    user&.instructor? && record.course.instructor_id == user.id
  end

  def admin?
    user&.admin?
  end
end
