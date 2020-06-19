class User < ApplicationRecord
  acts_as_voter
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy

  has_many :orders
  has_many :deliveries, through: :orders

  after_create :generate_stripe_customer

  validates_presence_of :first_name

  def stripe_customer
    Stripe::Customer.retrieve(stripe_customer_id)
  end

  def create_payment_intent(args)
    defaults = {
      currency: 'eur',
      customer: stripe_customer_id
    }

    # Will currently fail when (args[:amount] - balance) < 1
    # TODO: Add the credit adjustment on the webhook side
    if balance.positive?
      adjustment = [args[:amount], balance.to_cents].min

      args[:amount] -= adjustment

      args[:metadata] = (args[:metadata] || {}).merge(adjustment: -adjustment)
    end

    Stripe::PaymentIntent.create(defaults.merge(args))
  end

  def toggle_like(object)
    liked?(object) ? unlike(object) : likes(object)
  end

  def adjust_balance(amount)
    update(balance: balance + amount)
  end

  private

  def generate_stripe_customer
    customer = Stripe::Customer.create(
      email: email,
      metadata: {
        user_id: id
      }
    )

    update(stripe_customer_id: customer.id)
  end
end
