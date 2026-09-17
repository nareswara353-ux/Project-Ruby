module Users
  class SessionsController < Devise::SessionsController
    private

    def after_sign_in_path_for(resource)
      dashboard_path_for(resource)
    end

    def dashboard_path_for(user)
      return admin_dashboard_path if user.admin?
      return instructor_dashboard_path if user.instructor?

      dashboard_path
    end
  end
end
