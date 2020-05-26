Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_TEST_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.signing_secret = ENV['STRIPE_NGROK_SIGNING_SECRET']

# Needed to manually require here as initializers are run before zeitwerk autoloaders
require 'stripe/handlers/event'
require 'stripe/handlers/checkout_event'
require 'stripe/handlers/payment_intent_event'

StripeEvent.configure do |events|
	events.subscribe 'checkout.', Stripe::Handlers::CheckoutEvent.new
	events.subscribe 'payment_intent.', Stripe::Handlers::PaymentIntentEvent.new
end
