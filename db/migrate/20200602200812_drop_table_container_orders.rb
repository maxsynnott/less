class DropTableContainerOrders < ActiveRecord::Migration[6.0]
  def change
  	drop_table :container_orders
  end
end
