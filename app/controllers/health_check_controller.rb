class HealthCheckController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def show
    checks = {
      database: database_ok?,
      redis: redis_ok?,
      timestamp: Time.current.iso8601
    }
    status = checks[:database] ? :ok : :service_unavailable
    render json: checks, status: status
  end

  private

  def database_ok?
    ActiveRecord::Base.connection.active?
  rescue StandardError
    false
  end

  def redis_ok?
    Redis.new(url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/0" }).ping == "PONG"
  rescue StandardError
    false
  end
end
