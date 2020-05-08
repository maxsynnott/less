class Billing < ApplicationRecord
  belongs_to :user

  has_many :orders

  def create_orders
    orders = []

    if status == 'success' and metadata
      items = JSON.parse(JSON.parse(metadata)["items"])

      items.each do |item|
        order = Order.create(
          billing_id: id,
          product_id: item["product_id"],
          quantity: item["quantity"],
          price: BigDecimal(item["price"])
        )

        item["containers"].each { |container| order.check_out(Container.find(container["container_id"])) }

        orders << order
      end
    end

    orders
  end
end
