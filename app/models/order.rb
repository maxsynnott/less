class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def add(amount)
  	update(quantity: quantity + amount)
  end

  def remove(amount)
  	amount >= quantity ? destroy : update(quantity: quantity - amount)
  end

  def containerized
  	containers = Container.all.sort_by(&:size)

  	remaining = quantity

  	containerized_order = []

  	until remaining.zero?
  		container = containers.find { |container| container.size >= remaining }
  		container = containers.last unless container

  		amount = [remaining, container.size].min

  		containerized_order << {
  			container: container,
  			quantity: amount
  		}

  		remaining -= amount
  	end

  	containerized_order
  end
end
