class User < ApplicationRecord
  acts_as_voter
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :shop, optional: true

  has_one :cart, dependent: :destroy

  has_many :orders
  has_many :deliveries, through: :orders

  before_create :generate_cart

  after_create :generate_stripe_customer

  validates :phone, phone: { possible: true, allow_blank: true }

  # def toggle_like(object)
  #   liked?(object) ? unlike(object) : likes(object)
  # end

  private

  def generate_cart
    self.cart = Cart.new unless cart.present?
  end

  def generate_stripe_customer
    customer = Stripe::Customer.create(
      email: email,
      metadata: {
        id: id
      }
    )

    update(stripe_customer_id: customer.id)
  end
end
