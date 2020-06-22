class PaymentMethodsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_for User.find(params[:user_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
