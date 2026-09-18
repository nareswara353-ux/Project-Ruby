module Api
  module V1
    class BaseController < ActionController::API
      include Pundit::Authorization
      include ErrorHandling

      rescue_from Pundit::NotAuthorizedError, with: :handle_forbidden

      private

      def pundit_user
        current_api_user
      end

      def current_api_user
        @current_api_user
      end

      def handle_forbidden
        render json: { error: "Forbidden" }, status: :forbidden
      end
    end
  end
end
