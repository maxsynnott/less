class AddOrderItemToContainers < ActiveRecord::Migration[6.0]
  def change
    add_reference :containers, :order_item, foreign_key: true
  end
end
