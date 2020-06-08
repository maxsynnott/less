class Delivery < ApplicationRecord
  belongs_to :order

  validates_presence_of :address

  validates :phone, phone: { possible: true }

  # Returns all available datetimes (60 min increments)
  def self.available_dts
    slots = []

    hours_in_advance = 36 # Users must book at least n hours in advance
    days_ahead = 14 # Users can book up to n days ahead
    opening_hours = (10..17).to_a

    current_dt = DateTime.now.beginning_of_hour + 1.hour + hours_in_advance.hours
    end_dt = (current_dt + days_ahead.days).end_of_day

    until current_dt > end_dt
      unless current_dt.wday.zero? # Ignore sundays
        if opening_hours.include?(current_dt.hour)
          # TODO: Add logic to check for slots too busy to be booked
          slots << current_dt
        end
      end

      current_dt += 1.hour
    end

	  slots
  end

  def scheduled_at_time_display
    sprintf("%02d:00 to %02d:00", scheduled_at.hour, scheduled_at.hour + 1)
  end

  def scheduled_at_date_display
    scheduled_at.strftime("%B %d, %Y")
  end
end
