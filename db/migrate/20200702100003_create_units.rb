class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.references :item, null: false, foreign_key: true
      t.decimal :base_units, precision: 10, scale: 6, null: false
      t.string :name

      t.timestamps
    end
  end
end
