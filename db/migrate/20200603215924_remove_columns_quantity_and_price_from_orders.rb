class RemoveColumnsQuantityAndPriceFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :quantity, :integer
    remove_column :orders, :price, :decimal
  end
end
