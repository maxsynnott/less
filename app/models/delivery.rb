class Delivery < ApplicationRecord
  belongs_to :user
  belongs_to :address

  has_many :orders

  validates_presence_of :user

  # Returns all non-sundays in next two weeks
  def self.available_dates
  	day_after_tomorrow = Date.today + 2.days

  	dates = (day_after_tomorrow..day_after_tomorrow + 2.weeks).to_a

  	dates.reject { |date| date.wday.zero? } # Rejects all sundays
  end

  # Returns all available times (30 min increments) for a particular day
  def self.available_times(date)
  	slots = []

  	if Delivery.available_dates.include?(date)
	  	slots = (480..1080).step(30).to_a # Times are represented by minutes since midnight (480..1080) => (09:00..18:00)

	  	deliveries = Delivery.all.select { |delivery| delivery.scheduled_at.to_date == date }

	  	taken_times = deliveries.map { |delivery| delivery.scheduled_at.hour * 60 + delivery.scheduled_at.min }

	  	slots -= taken_times
	  end

	  slots
  end
end
