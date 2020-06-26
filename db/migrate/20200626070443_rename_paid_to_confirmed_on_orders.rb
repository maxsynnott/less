class RenamePaidToConfirmedOnOrders < ActiveRecord::Migration[6.0]
  def change
  	rename_column :orders, :paid, :confirmed
  end
end
