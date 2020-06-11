class DeliveryTrackerChannel < ApplicationCable::Channel
  def subscribed
    stream_for Delivery.find(params[:delivery_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
