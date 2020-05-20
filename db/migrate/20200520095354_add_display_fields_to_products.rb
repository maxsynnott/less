class AddDisplayFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :display_unit, :string, default: "kg"
    add_column :products, :display_unit_quantity, :integer, default: 1000
  end
end
