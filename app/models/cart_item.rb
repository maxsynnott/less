class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates_presence_of :cart, :quantity, :product

  def add(amount)
  	update(quantity: quantity + amount)
  end

  def remove(amount)
  	amount >= quantity ? destroy : update(quantity: quantity - amount)
  end

  def price
    product.price_for(quantity)
  end

  def containers
    remaining_containers = Container.all.select(&:returned?).sort_by(&:size)

    remaining_quantity = quantity

    if remaining_containers.sum(&:size) >= remaining_quantity
      containers = []

      until remaining_quantity.zero?
        # Finds the smallest container that will hold remaining otherwise takes largest
        container = remaining_containers.find { |container| container.size >= remaining_quantity }
        container = remaining_containers.last unless container

        remaining_containers.delete(container)

        containers << container

        remaining_quantity -= [remaining_quantity, container.size].min
      end

      containers
    else
      false
    end
  end
end
