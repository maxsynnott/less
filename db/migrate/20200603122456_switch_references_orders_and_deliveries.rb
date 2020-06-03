class SwitchReferencesOrdersAndDeliveries < ActiveRecord::Migration[6.0]
  def change
  	remove_reference :orders, :delivery

  	add_reference :deliveries, :order
  end
end
