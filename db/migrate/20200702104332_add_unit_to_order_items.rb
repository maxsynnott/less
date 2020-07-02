class AddUnitToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :unit, null: false, foreign_key: true
  end
end
