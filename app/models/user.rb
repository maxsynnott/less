class User < ApplicationRecord
  acts_as_voter
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy
  has_one :phone_number

  has_many :recipes
  has_many :billings
  has_many :orders, through: :billings
  has_many :deliveries, through: :orders
  has_many :cart_items, through: :cart

  before_create :generate_cart

  def address
    unless addresses.empty?
      addresses.length == 1 ? addresses.first : addresses.find { |addr| addr.selected }
    end
  end

  def toggle_like(object)
    liked?(object) ? unlike(object) : likes(object)
  end

  private

  def generate_cart
    self.cart = Cart.new unless cart.present?
  end
end
