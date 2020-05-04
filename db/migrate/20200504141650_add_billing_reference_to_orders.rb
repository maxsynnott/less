class AddBillingReferenceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :billing, null: false, foreign_key: true
  end
end
