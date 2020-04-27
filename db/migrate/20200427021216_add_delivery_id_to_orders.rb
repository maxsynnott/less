class AddDeliveryIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :delivery, foreign_key: true
  end
end
