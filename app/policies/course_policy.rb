class CoursePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.published? || owner? || admin?
  end

  def create?
    admin? || instructor?
  end

  def update?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end

  def students?
    admin? || owner?
  end

  def analytics?
    admin? || owner?
  end

  private

  def owner?
    user.present? && record.instructor_id == user.id
  end

  def admin?
    user&.admin?
  end

  def instructor?
    user&.instructor?
  end

  class Scope < Scope
    def resolve
      return scope.all if user&.admin?
      return scope.where(instructor: user).or(scope.published) if user&.instructor?
      scope.published
    end
  end
end
