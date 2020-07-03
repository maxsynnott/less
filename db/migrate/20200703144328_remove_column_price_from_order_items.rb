class RemoveColumnPriceFromOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :price, :decimal
  end
end
