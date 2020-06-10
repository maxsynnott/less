# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
	def new_order_email
		order = Order.new(
			paid: true,
			user: User.new(
					email: "user64@example.com",
					password: '123456',
					password_confirmation: '123456'
				),
			deliveries: [
				Delivery.new(
					delivered: false,
					price: 5.00,
					scheduled_at: DateTime.now.end_of_day + 2.days,
					address: "Rudi-Dustchke-Str. 26, Berlin",
					phone: "123456789"
				)
			]
		)

		OrderMailer.with(order: order).new_order_email
	end
end
