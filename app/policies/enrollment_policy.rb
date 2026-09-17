class EnrollmentPolicy < ApplicationPolicy
  def index?
    admin? || instructor_of_course?
  end

  def show?
    admin? || owner? || instructor_of_course?
  end

  def create?
    user&.student?
  end

  def destroy?
    admin? || owner?
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

  class Scope < Scope
    def resolve
      return scope.all if user&.admin?
      return scope.joins(:course).where(courses: { instructor_id: user.id }) if user&.instructor?

      scope.where(user: user)
    end
  end
end
