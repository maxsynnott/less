require 'rails_helper'

RSpec.feature "User views their orders" do
	before do
		@user = create(:user)

		login_as @user, scope: :user
	end

	context "they have orders" do
		context "they have both upcoming and past orders" do
			before do
				@order = create(:order, user: @user)
				future_datetime = (DateTime.now.in_time_zone("Berlin") + 3.days).change(hour: 14)
				@order.delivery.update(scheduled_at: future_datetime)

				@order_2 = create(:order, user: @user)
				past_datetime = (DateTime.now.in_time_zone("Berlin") - 3.days).change(hour: 10)
				@order_2.delivery.update(scheduled_at: past_datetime, delivered: true)
			end

			scenario "they see both their upcoming and past orders" do
				visit orders_path

				expect(page).to have_content "Upcoming Orders"
				expect(page).to have_content "Past Orders"
				expect(page).to have_css "a[data-toggle='collapse']", text: "14:00 to "
				expect(page).to have_css "a[data-toggle='collapse']", text: "10:00 to "
			end
		end

		context "they have upcoming orders" do
			before do
				@order = create(:order, user: @user)
				future_datetime = (DateTime.now.in_time_zone("Berlin") + 3.days).change(hour: 14)
				@order.delivery.update(scheduled_at: future_datetime)
			end

			scenario "they see their upcoming orders" do
				visit orders_path

				expect(page).to have_content "Upcoming Orders"
				expect(page).to have_css "a[data-toggle='collapse']", text: "14:00 to "

				expect(page).to_not have_content "Past Orders"
			end
		end

		context "they have past orders" do
			before do
				@order = create(:order, user: @user)
				past_datetime = (DateTime.now.in_time_zone("Berlin") - 3.days).change(hour: 10)
				@order.delivery.update(scheduled_at: past_datetime, delivered: true)
			end

			scenario "they see their past orders" do
				visit orders_path

				expect(page).to have_content "Past Orders"
				expect(page).to have_css "a[data-toggle='collapse']", text: "10:00 to "

				expect(page).to_not have_content "Upcoming Orders"
			end
		end
	end

	context "they have no orders" do
		scenario "they see no orders" do
			visit orders_path

			expect(page).to have_content "You haven't made any orders"
		end
	end
end