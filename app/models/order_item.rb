class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  has_many :containers

  before_create :assign_price

  after_create :assign_containers

  def total
  	quantity * price
  end

  private

  def assign_price
  	self.price = product.price
  end

  def assign_containers
    remaining_containers = Container.all.select(&:available?).sort_by(&:size)

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

    update(containers: containers)
  end
end
