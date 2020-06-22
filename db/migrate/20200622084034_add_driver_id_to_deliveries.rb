class AddDriverIdToDeliveries < ActiveRecord::Migration[6.0]
  def change
  	add_reference :deliveries, :driver, foreign_key: { to_table: :users }
  end
end
