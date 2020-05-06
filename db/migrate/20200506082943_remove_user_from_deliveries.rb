class RemoveUserFromDeliveries < ActiveRecord::Migration[6.0]
  def change
    remove_reference :deliveries, :user, null: false, foreign_key: true
  end
end
