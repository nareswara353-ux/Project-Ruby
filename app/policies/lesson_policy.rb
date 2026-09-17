class LessonPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    admin? || instructor_of_course?
  end

  def update?
    admin? || instructor_of_course?
  end

  def destroy?
    admin? || instructor_of_course?
  end

  private

  def instructor_of_course?
    user&.instructor? && record.course.instructor_id == user.id
  end

  def admin?
    user&.admin?
  end
end
