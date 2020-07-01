Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_TEST_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

if Rails.env.test?
	StripeEvent.signing_secret = ENV['STRIPE_NGROK_RSPEC_SIGNING_SECRET']
else
	StripeEvent.signing_secret = ENV['STRIPE_NGROK_PRODUCTION_SIGNING_SECRET']
end

# Needed to manually require here as initializers are run before zeitwerk autoloaders
require 'stripe/handlers/event'
require 'stripe/handlers/payment_intent_event'

StripeEvent.configure do |events|
	events.subscribe 'payment_intent.', Stripe::Handlers::PaymentIntentEvent.new
end
