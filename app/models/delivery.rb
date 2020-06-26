class Delivery < ApplicationRecord
  scope :unaccepted, -> { where(driver_id: nil) }
  
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  
  before_save :broadcast_driver_coordinates, if: Proc.new { |d| d.will_save_change_to_driver_latitude? or d.will_save_change_to_driver_longitude? }
  before_save :broadcast_status, if: :will_save_change_to_status?

  belongs_to :order
  belongs_to :driver, optional: true

  validates_presence_of :address, :scheduled_at, :phone

  before_validation :assign_price

  validates :phone, phone: true

  def time_slot
    TimeSlot.new(start_datetime: scheduled_at)
  end

  def scheduled_date_string
    scheduled_at.strftime('%B %d')
  end

  def scheduled_slot_string
    "#{scheduled_at.strftime('%H:%M')} to #{(scheduled_at + 2.hours).strftime('%H:%M')}"
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