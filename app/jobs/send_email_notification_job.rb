class SendEmailNotificationJob < ApplicationJob
  queue_as :default

  retry_on Net::SMTPError, wait: :polynomially_longer, attempts: 5

  def perform(user_id, mailer_class, mailer_method, params = {})
    user = User.find(user_id)
    mailer = mailer_class.constantize.public_send(mailer_method, user, **params.symbolize_keys)
    mailer.deliver_now
  end
end
