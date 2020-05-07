class CreateContainerOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :container_orders do |t|
      t.datetime :checked_out_at
      t.datetime :returned_at
      t.references :container, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
