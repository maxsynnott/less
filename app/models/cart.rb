class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, inverse_of: :cart

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
    line_items = []
    line_containers = []

    cart_items.each do |cart_item|
      containers = cart_item.containers

      if containers
        line_items << {
          name: cart_item.product.name,
          description: cart_item.quantity.to_s + 'g',
          quantity: 1,
          currency: 'eur',
          amount: cart_item.price.to_cents
        }

        line_containers += containers
      end
    end

    line_containers.sort_by { |lc| [lc.price, lc.size] }.reverse.each do |line_container|
      line_items << {
        name: line_container.name,
        description: "Pfand",
        quantity: 1,
        currency: 'eur',
        amount: line_container.price.to_cents
      }
    end

    line_items
  end

  def total
    # Converted to cents and back to money to ensure no rounding disrepencies
    cart_items.sum { |cart_item| cart_item.price.to_cents }.to_money
  end

  def to_metadata
    items = cart_items.map do |cart_item|
      {
        product_id: cart_item.product.id,
        quantity: cart_item.quantity,
        price: cart_item.product.price,
        containers: cart_item.containers.map { |container| { container_id: container.id, price: container.price } }
      }
    end

    {
      user_id: user.id,
      items: items.to_json, # Neccesary to convert items to string as stripe API won't accept nested
      total: total
    }
  end

  def empty?
    cart_items.empty?
  end
end
