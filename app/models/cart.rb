class Cart < ApplicationRecord
  belongs_to :user, optional: true

  has_many :cart_items, dependent: :destroy, inverse_of: :cart

  accepts_nested_attributes_for :cart_items, reject_if: :all_blank, allow_destroy: true

  def add_cart_item(cart_item)
    add_unit(cart_item.unit, cart_item.quantity)
  end

  def add_unit(unit, amount = 1)
  	cart_item = cart_items.find { |cart_item| cart_item.unit == unit }

  	if cart_item
  		cart_item.add(amount)
  	else
  		CartItem.create(unit_id: unit.id, cart_id: id, quantity: amount)
  	end
  end

  def clear
  	cart_items.destroy_all
  end

  def find_cart_item(item)
  	cart_items.find { |cart_item| cart_item.item_id == item.id }
  end

  def total
    # Converted to cents and back to money to ensure no rounding disrepencies
    cart_items.sum { |cart_item| cart_item.total.to_cents }.to_money
  end

  def empty?
    cart_items.empty?
  end

  def to_order_items
    cart_items.map(&:to_order_item)
  end

  def count
    cart_items.count
  end
end
