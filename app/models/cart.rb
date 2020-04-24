class Cart < ApplicationRecord
  belongs_to :user

  has_many :orders

  def add_product(product, amount = 1)
  	order = find_order(product)

  	if order
  		order.add(amount)
  	else
  		Order.create(product_id: product.id, cart_id: id, quantity: amount)
  	end
  end

  def remove_product(product, amount = nil)
  	order = find_order(product)

  	if order
  		amount ? order.remove(amount) : order.destroy
  	end
  end

  def quantity_of(product)
  	find_order(product).try(:quantity)
  end

  def clear
  	orders.destroy_all
  end

  def find_order(product)
  	orders.find { |order| order.product_id == product.id }
  end
end
