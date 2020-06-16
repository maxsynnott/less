class AddDriverCoordinatesToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :driver_longitude, :float
    add_column :deliveries, :driver_latitude, :float
  end
end
