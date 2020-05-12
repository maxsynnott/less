require 'rails_helper'

RSpec.describe Delivery, 'validations' do
	[]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end

RSpec.describe Delivery, '#available_times' do
	context 'when there are no existing deliveries' do
		it 'should return all times between 08:00 and 18:00' do
			monday = Date.today.next_week

			times = Delivery.available_times(monday)

			expect(times).to eq (480..1020).step(60).to_a
		end

		it 'should return no times when on a sunday' do
			sunday = Date.today.next_week + 1.week - 1.day

			times = Delivery.available_times(sunday)

			expect(times).to eq []
		end
	end

	context 'when there are existing deliveries on the same day' do
		it 'should exclude appropriate times' do
			monday = Date.today.next_week

			# Should exclude 840 as there are 2 deliveries
			create(:delivery, scheduled_at: monday.to_datetime.change(hour: 14))
			create(:delivery, scheduled_at: monday.to_datetime.change(hour: 14))

			# Should exclude 900 as there are more than 2 deliveries
			create(:delivery, scheduled_at: monday.to_datetime.change(hour: 15))
			create(:delivery, scheduled_at: monday.to_datetime.change(hour: 15))
			create(:delivery, scheduled_at: monday.to_datetime.change(hour: 15))

			# Shouldn't exclude 960 as there is less than 2 deliveries
			create(:delivery, scheduled_at: monday.to_datetime.change(hour: 16))

			times = Delivery.available_times(monday)

			expect(times).to eq (480..1020).step(60).to_a - [840, 900]
		end
	end
end

# Gonna have to deal with time_zone stuff at some point
RSpec.describe Delivery, "#scheduled_at_time_display" do
	let(:delivery) { create(:delivery, scheduled_at: DateTime.now.in_time_zone("UTC").change(hour: 10, min: 00)) }

	it "returns time in correct human-friendly format" do
		time_display = delivery.scheduled_at_time_display

		expect(time_display).to eq "10:00 to 11:00"
	end
end

# Gonna have to deal with time_zone stuff at some point
RSpec.describe Delivery, "#scheduled_at_date_display" do
	let(:delivery) { create(:delivery, scheduled_at: DateTime.now.in_time_zone("UTC").change(year: 2029, month: 3, day: 10)) }

	it "returns date in correct human-friendly format" do
		date_display = delivery.scheduled_at_date_display

		expect(date_display).to eq "March 10, 2029"
	end
end