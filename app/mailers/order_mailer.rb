class OrderMailer < ApplicationMailer
	def new_order_email
		@order = params[:order]

		mail(to: "max@lessberlin.de", subject: "You've got a new order!")
	end
end
