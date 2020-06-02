class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, inverse_of: :cart # For cocoon gem

  validates_presence_of :user

  accepts_nested_attributes_for :cart_items, reject_if: :all_blank, allow_destroy: true

  def add_product(product, amount = 1)
  	cart_item = find_cart_item(product)

  	if cart_item
  		cart_item.add(amount)
  	else
  		CartItem.create(product_id: product.id, cart_id: id, quantity: amount)
  	end
  end

  # Currently unused
  # def quantity_of(product)
  # 	find_cart_item(product).try(:quantity)
  # end

  def clear
  	cart_items.destroy_all
  end

  def find_cart_item(product)
  	cart_items.find { |cart_item| cart_item.product_id == product.id }
  end

  def line_items
    cart_items.map do |cart_item|
      {
        name: cart_item.product.name,
        description: cart_item.quantity.to_s + 'g',
        quantity: 1,
        currency: 'eur',
        amount: cart_item.price.to_cents
      }
    end
  end

  def total
    # Converted to cents and back to money to ensure no rounding disrepencies
    cart_items.sum { |cart_item| cart_item.price.to_cents }.to_money
  end

  def empty?
    cart_items.empty?
  end
end
