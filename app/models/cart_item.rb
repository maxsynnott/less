class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :unit

  delegate :item, to: :unit, allow_nil: true

  validates_presence_of :cart, :quantity, :unit

  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  def add(amount)
  	amount.positive? ? update(quantity: quantity + amount) : false
  end

  def total
    unit.price * quantity
  end

  def to_order_item
    OrderItem.new(
      unit_id: unit.id,
      quantity: quantity,
      price: unit.price
    )
  end
end
