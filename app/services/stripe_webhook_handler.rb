class StripeWebhookHandler
  def initialize(event)
    @event = event
  end

  def call
    case event.type
    when "checkout.session.completed" then handle_checkout_completed
    when "payment_intent.payment_failed" then handle_payment_failed
    end
  end

  private

  attr_reader :event

  def handle_checkout_completed
    session = event.data.object
    payment = Payment.find_by(id: session.client_reference_id)
    payment&.mark_successful!
  end

  def handle_payment_failed
    intent = event.data.object
    payment = Payment.find_by(stripe_payment_intent_id: intent.id)
    payment&.mark_failed!
  end
end
