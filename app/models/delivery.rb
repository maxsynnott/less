class Delivery < ApplicationRecord
  belongs_to :order

  validates_presence_of :address

  validates :phone, phone: { possible: true }

  # Returns all available datetimes (60 min increments)
  def self.available_dts
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
end