class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_create :assign_price

  def total
  	quantity * price
  end

  private

  def assign_price
  	self.price = product.price
  end
end
