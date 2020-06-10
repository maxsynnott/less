class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  validates_presence_of :cart, :quantity, :item

  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  def add(amount)
  	amount.positive? ? update(quantity: quantity + amount) : false
  end

  # Currently unused
  # def remove(amount)
  # 	amount >= quantity ? destroy : update(quantity: quantity - amount)
  # end

  def price
    item.price_for(quantity)
  end

  def to_order_item
    OrderItem.new(
      item_id: item.id,
      quantity: quantity,
      price: item.price
    )
  end
end
