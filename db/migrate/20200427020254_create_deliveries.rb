class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :price
      t.boolean :delivered
      t.references :address, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
