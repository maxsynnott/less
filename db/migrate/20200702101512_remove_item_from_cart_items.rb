class RemoveItemFromCartItems < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cart_items, :item, null: false, foreign_key: true
  end
end
