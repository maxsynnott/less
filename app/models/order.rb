class Order < ApplicationRecord
	belongs_to :user

	has_one :delivery, inverse_of: :order
	has_many :order_items, inverse_of: :order, dependent: :destroy

	accepts_nested_attributes_for :delivery, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

	validates_presence_of :user

	validate :payment_method_id_is_valid, unless: Proc.new { |o| o.paid? or !o.user or Rails.env.test? }

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

	def delivered?
		delivery.delivered?
	end

	def create_payment_intent(args)
	  defaults = {
	    currency: 'eur',
	    customer: user.stripe_customer_id,
	    amount: total.to_cents,
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

	private

	def payment_method_id_is_valid
		payment_method_ids = Stripe::PaymentMethod.list(
			customer: user.stripe_customer_id,
			type: 'card'
		).data.map(&:id)

		errors.add(:payment_method_id, "must be valid") unless payment_method_ids.include?(payment_method_id)
	end
end
