class StripeCheckoutService
  def initialize(payment)
    @payment = payment
  end

  def call
    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: [line_item],
      mode: "payment",
      success_url: "#{base_url}/payments/#{payment.id}?status=success",
      cancel_url: "#{base_url}/courses/#{payment.course.slug}?status=cancel",
      client_reference_id: payment.id.to_s,
      customer_email: payment.user.email
    )
    payment.update!(stripe_payment_intent_id: session.payment_intent)
    session.url
  end

  private

  attr_reader :payment

  def line_item
    {
      price_data: {
        currency: payment.currency,
        product_data: { name: payment.course.title },
        unit_amount: (payment.amount * 100).to_i
      },
      quantity: 1
    }
  end

  def base_url
    ENV.fetch("APP_HOST", "http://localhost:3000")
  end
end
