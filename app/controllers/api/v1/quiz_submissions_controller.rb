module Api
  module V1
    class QuizSubmissionsController < BaseController
      before_action :authenticate_api_user!
      before_action :set_submission, only: [:show]

      def create
        quiz = Quiz.find(params[:quiz_id])
        submission = quiz.quiz_submissions.create!(
          user: current_api_user,
          status: :in_progress,
          started_at: Time.current
        )
        authorize submission, :create?
        render json: QuizSubmissionSerializer.serialize(submission), status: :created
      end

      def show
        authorize @submission, :show?
        render json: QuizSubmissionSerializer.serialize(@submission)
      end

      private

      attr_reader :current_api_user

      def set_submission
        @submission = QuizSubmission.find(params[:id])
      end

      def authenticate_api_user!
        token = request.headers["Authorization"]&.split(" ")&.last
        @current_api_user = User.find_by(api_token: token) if token.present?
        render json: { error: "Unauthorized" }, status: :unauthorized unless @current_api_user
      end
    end
  end
end
