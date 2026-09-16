module Api
  module V1
    class EnrollmentsController < ActionController::API
      before_action :authenticate_api_user!

      def create
        course = Course.find(params[:course_id])
        result = CourseEnrollmentService.new(user: current_api_user, course: course).call
        if result.success?
          render json: { id: result.enrollment.id, status: result.enrollment.status }, status: :created
        else
          render json: { error: result.error }, status: :unprocessable_entity
        end
      end

      def destroy
        enrollment = current_api_user.enrollments.find(params[:id])
        authorize enrollment, :destroy?
        enrollment.destroy
        head :no_content
      end

      private

      def authenticate_api_user!
        token = request.headers["Authorization"]&.split(" ")&.last
        @current_api_user = User.find_by(api_token: token) if token.present?
        render json: { error: "Unauthorized" }, status: :unauthorized unless @current_api_user
      end

      def current_api_user
        @current_api_user
      end
    end
  end
end
