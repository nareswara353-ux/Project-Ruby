Devise.setup do |config|
  config.mailer_sender = ENV.fetch("DEFAULT_EMAIL_FROM") { "noreply@lms.com" }
  require "devise/orm/active_record"
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.lock_strategy = :failed_attempts
  config.unlock_strategy = :both
  config.maximum_attempts = 5
  config.unlock_in = 1.hour
  config.last_attempt_warning = true
  config.confirmation_keys = [:email]
  config.remember_for = 2.weeks
  config.timeout_in = 30.minutes
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
