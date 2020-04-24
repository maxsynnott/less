class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def add(amount)
  	update(quantity: quantity + amount)
  end

  def remove(amount)
  	amount >= quantity ? destroy : update(quantity: quantity - amount)
  end
end
