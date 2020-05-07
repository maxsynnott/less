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

  def containerized
  	containers = Container.all.sort_by(&:size)

  	remaining = quantity

  	containerized_item = []

  	until remaining.zero?
  		container = containers.find { |container| container.size >= remaining }
  		container = containers.last unless container

  		amount = [remaining, container.size].min

  		containerized_item << {
  			container: container,
  			quantity: amount
  		}

  		remaining -= amount
  	end

  	containerized_item
  end

  def containers
    containers = Container.all.sort_by(&:size)

    remaining = quantity
  end
end
