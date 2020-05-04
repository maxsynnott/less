class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart
  has_one :phone_number

  has_many :addresses
  has_many :orders
  has_many :deliveries

  validates_presence_of :cart

  def address
    unless addresses.empty?
      addresses.length.one? ? addresses.first : addresses.find { |addr| addr.selected }
    end
  end
end
