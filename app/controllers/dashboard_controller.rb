class DashboardController < ApplicationController
  def index
    @enrollments = current_user.enrollments.includes(:course).order(created_at: :desc)
    @certificates = current_user.certificates.includes(:course)
    @recent_notifications = current_user.notifications.recent.limit(5)
  end

  def instructor
    authorize :dashboard, :instructor?
    @courses = current_user.courses.includes(:enrollments, :modules)
    @total_students = Enrollment.where(course: @courses).distinct.count(:user_id)
    @total_revenue = Payment.successful.where(course: @courses).sum(:amount)
  end

  def admin
    authorize :dashboard, :admin?
    @users_count = User.count
    @courses_count = Course.count
    @enrollments_count = Enrollment.count
    @revenue_total = Payment.successful.sum(:amount)
    @recent_payments = Payment.successful.recent.limit(10)
  end
end
