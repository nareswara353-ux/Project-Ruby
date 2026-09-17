class QuizPolicy < ApplicationPolicy
  def show?
    admin? || instructor_of_course? || enrolled_student?
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

  def start?
    enrolled_student?
  end

  def submit?
    enrolled_student?
  end

  private

  def enrolled_student?
    user&.student? && Enrollment.exists?(user: user, course: record.course, status: :active)
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

      scope.joins(course: :enrollments).where(enrollments: { user_id: user.id, status: :active })
    end
  end
end
