class Order < ApplicationRecord
	belongs_to :user

	has_one :delivery, inverse_of: :order
	has_many :order_items, inverse_of: :order, dependent: :destroy

	accepts_nested_attributes_for :delivery, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

	validates_presence_of :user, :delivery, :payment_method_id

	def add_to_cart(cart)
		order_items.each { |order_item| order_item.add_to_cart(cart) }
	end

	def subtotal
		order_items.sum(&:total)
	end

	def delivery_price
		delivery.try(:price).to_i
	end

	def total
		subtotal + delivery_price
	end

	def confirm
		# Add more to this
		# Send emails etc.
		update(confirmed: true)
		user.cart.clear

		OrderRefreshChannel.broadcast_to self, { refresh: true }
	end

	def create_payment_intent(args)
	  defaults = {
	    currency: 'eur',
	    customer: user.stripe_customer_id,
	    amount: BigDecimal(total).to_cents,
	    metadata: {
	    	order_id: id
	    }
	  }

	  Stripe::PaymentIntent.create(defaults.merge(args))
	end

	def breakdown
		{
			subtotal: subtotal,
			delivery: delivery_price,
			total: total
		}
	end

	def packed?
	  Date.today == delivery.scheduled_at.to_date
	end

	def on_the_way?
	  DateTime.now >= delivery.scheduled_at
	end

	def delivered?
		delivery.delivered?
	end

	def milestone
		# Milstones:
		# 0: Confirmed
		# 1: Packed
		# 2: On the way
		# 3: Delivered
		current_milestone = nil

		if confirmed?
		  current_milestone = 0

		  if packed?
		    current_milestone = 1

		    if on_the_way?
		      current_milestone = 2

		      if delivered?
		        current_milestone = 3
		      end
		    end
		  end
		end

		current_milestone
	end
end
