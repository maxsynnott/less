class AddUnitToCartItem < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :unit, :string, null: false
  end
end
