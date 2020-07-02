class Cart < ApplicationRecord
  belongs_to :user, optional: true

  has_many :cart_items, dependent: :destroy, inverse_of: :cart

  accepts_nested_attributes_for :cart_items, reject_if: :all_blank, allow_destroy: true

  def add_item(item, amount = 1)
  	cart_item = find_cart_item(item)

  	if cart_item
  		cart_item.add(amount)
  	else
  		CartItem.create(item_id: item.id, cart_id: id, quantity: amount)
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
