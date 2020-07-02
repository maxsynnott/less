class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :unit

  delegate :item, to: :unit, allow_nil: true

  has_many :containers, dependent: :nullify

  after_initialize :assign_price

  after_create :assign_containers

  def total
  	quantity * price
  end

  def add_to_cart(cart)
    cart.add_item(item, quantity)
  end

  private

  def assign_price
  	self.price = unit.price
  end

  # This assigns the least amount of containers possible however in some cases not the most efficient use of containers
  # Eg. quantity of 350 with containers: [50, 300, 500] will currently be assigned [500]
  # This should be reworked at some point however not simple due to time complexity issues with large num of containers in db
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
