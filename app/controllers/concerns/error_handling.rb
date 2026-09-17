module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  end

  private

  def handle_not_found(error)
    respond_error("Record not found: #{error.message}", :not_found)
  end

  def handle_parameter_missing(error)
    respond_error("Missing parameter: #{error.param}", :bad_request)
  end

  def respond_error(message, status)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, alert: message) }
      format.json { render json: { error: message }, status: status }
    end
  end
end
