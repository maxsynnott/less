Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_TEST_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.signing_secret = ENV['STRIPE_NGROK_SIGNING_SECRET']

StripeEvent.configure do |events|
	events.subscribe 'checkout.', Stripe::Handlers::CheckoutEvent.new
end
