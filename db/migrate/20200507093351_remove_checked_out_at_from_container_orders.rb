class RemoveCheckedOutAtFromContainerOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :container_orders, :checked_out_at, :datetime
  end
end
