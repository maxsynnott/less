class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items

  validates_presence_of :user

  def add_product(product, amount = 1)
  	cart_item = find_cart_item(product)

  	if cart_item
  		cart_item.add(amount)
  	else
  		CartItem.create(product_id: product.id, cart_id: id, quantity: amount)
  	end
  end

  def remove_product(product, amount = nil)
  	cart_item = find_cart_item(product)

  	if cart_item
  		amount ? cart_item.remove(amount) : cart_item.destroy
  	end
  end

  def quantity_of(product)
  	find_cart_item(product).try(:quantity)
  end

  def clear
  	cart_items.destroy_all
  end

  def find_cart_item(product)
  	cart_items.find { |cart_item| cart_item.product_id == product.id }
  end

  def line_items
    items = []

    cart_items.each do |cart_item|
      product = cart_item.product

      cart_item.containerized.each do |item|
        item = {
          name: "#{product.name} | #{item[:quantity]}g",
          description: item[:container].name,
          quantity: 1,
          currency: 'eur',
          amount: product.cents_price_for(item[:quantity])
        }

        items << item
      end
    end

    items
  end

  def cents_total
    cart_items.sum { |cart_item| cart_item.product.cents_price_for(cart_item.quantity) }
  end

  def total
    cart_items.sum { |cart_item| cart_item.product.price_for(cart_item.quantity) }
  end
end
