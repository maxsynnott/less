require 'rails_helper'

RSpec.describe Delivery, 'validations' do
	[:user]
	.each { |attr| it { should validate_presence_of(attr) } }
end

RSpec.describe Delivery, '#available_times' do
	context 'when there are no existing deliveries' do
		it 'should return all times between 08:00 and 18:00' do
			monday = Date.today.next_week

			times = Delivery.available_times(monday)

			expect(times).to eq (480..1080).step(30).to_a
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

			create(:delivery, scheduled_at: monday.to_datetime.change(hour: 14))

			times = Delivery.available_times(monday)

			expect(times).to eq (480..1080).step(30).to_a - [840]
		end
	end
end