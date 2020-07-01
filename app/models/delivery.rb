class Delivery < ApplicationRecord
  scope :unaccepted, -> { where(driver_id: nil) }
  
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  
  before_save :broadcast_driver_coordinates, if: Proc.new { |d| d.will_save_change_to_driver_latitude? or d.will_save_change_to_driver_longitude? }

  belongs_to :order
  belongs_to :driver, optional: true

  validates_presence_of :address, :scheduled_at, :phone

  after_initialize :assign_price

  validates :phone, phone: true

  def price_for(time_slot)
    if order.subtotal < 35
      5
    elsif time_slot.start_datetime.wday == 6
      2
    else
      0
    end
  end

  def time_slot
    TimeSlot.new(start_datetime: scheduled_at) if scheduled_at
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
    self.price = time_slot ? price_for(time_slot) : 0
  end

  def broadcast_driver_coordinates
    DeliveryTrackerChannel.broadcast_to self, { latitude: driver_latitude, longitude: driver_longitude }
  end
end