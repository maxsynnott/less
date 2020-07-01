class RemoveStatusFromDeliveries < ActiveRecord::Migration[6.0]
  def change
    remove_column :deliveries, :status, :string
  end
end
