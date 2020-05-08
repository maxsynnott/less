class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates_presence_of :cart, :quantity, :product

  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  validate :sufficient_stock, if: -> { product and quantity }

  def add(amount)
  	update(quantity: quantity + amount)
  end

  def remove(amount)
  	amount >= quantity ? destroy : update(quantity: quantity - amount)
  end

  def price
    product.price_for(quantity)
  end

  # Improve this in the future to return the containers resulting in the most efficient use of space
  def containers
    remaining_containers = Container.all.select(&:returned?).sort_by(&:size)

    remaining_quantity = quantity

    containers = []

    if remaining_containers.sum(&:size) >= remaining_quantity
      until remaining_quantity.zero?
        # Finds the smallest container that will hold remaining otherwise takes largest
        container = remaining_containers.find { |container| container.size >= remaining_quantity }
        container = remaining_containers.last unless container

        remaining_containers.delete(container)

        containers << container

        remaining_quantity -= [remaining_quantity, container.size].min
      end
    end

    containers
  end

  private

  def sufficient_stock
    if quantity > self.product.stock
      errors.add(:quantity, "Insufficient stock")
    end
  end
end
