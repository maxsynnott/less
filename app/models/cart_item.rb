class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates_presence_of :cart, :quantity, :product

  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  def add(amount)
  	amount.positive? ? update(quantity: quantity + amount) : false
  end

  # Currently unused
  # def remove(amount)
  # 	amount >= quantity ? destroy : update(quantity: quantity - amount)
  # end

  def price
    product.price_for(quantity)
  end
end
