class AddAddressToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :address, :string
  end
end
