class Order < ApplicationRecord
	belongs_to :user

	has_many :deliveries, inverse_of: :order
	has_many :order_items, inverse_of: :order, dependent: :destroy

	accepts_nested_attributes_for :deliveries, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

	validates_presence_of :user

	validate :payment_method_id_is_valid, unless: :paid?

	def total
		order_items.sum(&:total)
	end

	def delivered?
		deliveries.all?(&:delivered?)
	end

	# Remove this + related logic if support for multiple deliveries ever added
	def delivery
		deliveries.first
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
			subtotal: total,
			delivery: delivery.try(:price),
			total: total + (delivery.try(:price) or 0)
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
