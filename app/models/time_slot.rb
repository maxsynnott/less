class TimeSlot
	include ActiveModel::Model

	attr_accessor :start_datetime, :end_datetime

	@@slot_length = 2.hours

	def initialize(args)
		@slot_length = args[:slot_length] || 2.hours

		@start_datetime = args[:start_datetime]
		@end_datetime = @start_datetime + @@slot_length
	end

	def self.available
    time_slots = []

    min_in_advance = 36.hours # Users must book at least x in advance
    max_in_advance = 14.days # Users can book up to x ahead
    delivery_hours = (9..17).to_a
    max_bookings_per_slot = 3

    current_dt = DateTime.now.beginning_of_hour + 1.hour + min_in_advance
    last_dt = (current_dt + max_in_advance).end_of_day

    until current_dt > last_dt
      unless current_dt.wday.zero? # Ignore sundays
        if delivery_hours.include?(current_dt.hour)
          # TODO: Add complex logic to check for slots too busy to be booked
          if Delivery.where(scheduled_at: current_dt).count < max_bookings_per_slot
          	time_slots << TimeSlot.new(start_datetime: current_dt)
          end
        end
      end

      current_dt += 1.hour
    end

	  time_slots
	end

	def date
		@start_datetime.to_date
	end

	def to_s
		"#{@start_datetime.strftime('%H:%M')} to #{@end_datetime.strftime('%H:%M')}"
	end
end