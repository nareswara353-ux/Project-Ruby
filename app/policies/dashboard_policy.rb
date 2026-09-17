class DashboardPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def instructor?
    user&.instructor? || user&.admin?
  end

  def admin?
    user&.admin?
  end
end
