class Delivery < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  
  before_save :broadcast_driver_coordinates, if: Proc.new { |d| d.will_save_change_to_driver_latitude? or d.will_save_change_to_driver_longitude? }
  before_save :broadcast_status, if: :will_save_change_to_status?

  belongs_to :order

  validates_presence_of :address, :scheduled_at

  before_validation :assign_price

  validates :phone, phone: { possible: true }

  # Returns all available datetimes (60 min increments)
  def self.available_datetimes
    slots = []

    min_in_advance = 36.hours # Users must book at least x in advance
    max_in_advance = 14.days # Users can book up to x ahead
    opening_hours = (10..17).to_a
    bookings_per_slot = 2

    current_dt = DateTime.now.beginning_of_hour + 1.hour + min_in_advance
    end_dt = (current_dt + max_in_advance).end_of_day

    until current_dt > end_dt
      unless current_dt.wday.zero? # Ignore sundays
        if opening_hours.include?(current_dt.hour)
          # TODO: Add complex logic to check for slots too busy to be booked
          slots << current_dt if Delivery.where(scheduled_at: current_dt).count < bookings_per_slot
        end
      end

      current_dt += 1.hour
    end

	  slots
  end

  private

  def assign_price
    # Simple placeholder logic
    self.price = order.total >= 35 ? 0 : 5
  end

  def broadcast_status
    DeliveryTrackerChannel.broadcast_to self, { status: status }
  end

  def broadcast_driver_coordinates
    DeliveryTrackerChannel.broadcast_to self, { latitude: driver_latitude, longitude: driver_longitude }
  end
end