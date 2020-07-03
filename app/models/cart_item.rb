class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :unit

  delegate :item, to: :unit, allow_nil: true

  validates_presence_of :cart, :quantity, :unit

  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  def add(amount)
  	amount.positive? ? update(quantity: quantity + amount) : false
  end

  def total
    unit.price * quantity
  end

  def to_order_item
    OrderItem.new(
      unit_id: unit.id,
      quantity: quantity
    )
  end

  def container_type_count
    container_types = ContainerType.where(id: item.container_type_ids).sort_by(&:size)
    container_type_count = container_types.map { |ct| [ct, 0] }.to_h

    remaining_quantity = quantity * unit.base_units

    until remaining_quantity.zero?
      # Finds the smallest container that will hold remaining otherwise takes largest
      container_type = container_types.find { |container_type| container_type.size >= remaining_quantity }
      container_type = container_types.last unless container_type

      container_type_count[container_type] += 1

      remaining_quantity -= [remaining_quantity, container_type.size].min
    end

    container_type_count
  end

  def required_containers
    p container_type_count
    container_type_count.to_a.map { |arr| arr[0].containers.select(&:available?).sample(arr[1]) }.flatten
  end
end
