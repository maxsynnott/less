class OrderRefreshChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_for Order.find(params[:order_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
