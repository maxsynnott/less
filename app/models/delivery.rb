class Delivery < ApplicationRecord
  belongs_to :address

  has_one :order

  # Returns all non-sundays in next two weeks
  def self.available_dates
  	day_after_tomorrow = Date.today + 2.days

  	dates = (day_after_tomorrow..day_after_tomorrow + 12.days).to_a

  	dates.reject { |date| date.wday.zero? or Delivery.available_times(date).empty? } # Rejects all sundays and full days
  end

  # Returns all available times (60 min increments) for a particular day
  def self.available_times(date)
  	slots = []

  	if date >= Date.today && date <= Date.today + 12.days and !date.wday.zero?
	  	slots = (480..1020).step(60).to_a # Times are represented by minutes since midnight (480..1020) => (09:00..17:00)

	  	deliveries = Delivery.all.select { |delivery| delivery.scheduled_at.to_date == date }

	  	taken_times = deliveries.map { |delivery| delivery.scheduled_at.hour * 60 + delivery.scheduled_at.min }

      taken_times.reject! { |time| taken_times.count(time) < 2 } # Slot is only full if it has 2 or more deliveries

	  	slots -= taken_times
	  end

	  slots
  end

  def self.next_available_datetime
    date = Delivery.available_dates.first
    time_mins = Delivery.available_times(date).first

    date.to_datetime.change(hour: time_mins / 60, min: time_mins % 60)
  end

  def scheduled_at_time_display
    sprintf("%02d:00 to %02d:00", scheduled_at.hour, scheduled_at.hour + 1)
  end

  def scheduled_at_date_display
    scheduled_at.strftime("%B %d, %Y")
  end
end
