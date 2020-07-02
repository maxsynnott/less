class CreateContainerTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :container_types do |t|
      t.string :name
      t.integer :size
      t.decimal :price, precision: 10, scale: 6

      t.timestamps
    end
  end
end
