class AddPaymentMethodIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_method_id, :string
  end
end
