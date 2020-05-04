module Stripe
  class EventHandler
    def call(event)
      send 'handle_' + event.type.tr('.', '_'), event
    rescue JSON::ParserError => e
      render json: { status: 400, error: 'Invalid payload' }
      Raven.capture_exception(e)
    rescue Stripe::SignatureVerificationError => e
      render json: { status: 400, error: 'Invalid signature' }
      Raven.capture_exception(e)
    end
  end
end