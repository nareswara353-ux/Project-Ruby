class StripeWebhookVerifier
  def initialize(request)
    @request = request
  end

  def verify
    payload = request.body.read
    signature = request.env["HTTP_STRIPE_SIGNATURE"]
    Stripe::Webhook.construct_event(payload, signature, webhook_secret)
  end

  private

  attr_reader :request

  def webhook_secret
    ENV.fetch("STRIPE_WEBHOOK_SECRET") { "" }
  end
end
