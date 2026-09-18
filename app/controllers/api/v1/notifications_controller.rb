module Api
  module V1
    class NotificationsController < BaseController
      before_action :authenticate_api_user!

      def index
        notifications = current_api_user.notifications.recent
        render json: NotificationSerializer.serialize(notifications)
      end

      def update
        notification = current_api_user.notifications.find(params[:id])
        notification.mark_as_read!
        render json: NotificationSerializer.serialize(notification)
      end

      private

      attr_reader :current_api_user

      def authenticate_api_user!
        token = request.headers["Authorization"]&.split(" ")&.last
        @current_api_user = User.find_by(api_token: token) if token.present?
        render json: { error: "Unauthorized" }, status: :unauthorized unless @current_api_user
      end
    end
  end
end
