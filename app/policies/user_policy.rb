class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    admin? || owner?
  end

  private

  def owner?
    user.present? && record.id == user.id
  end

  def admin?
    user&.admin?
  end
end
