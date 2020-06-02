class RedefiningRelations < ActiveRecord::Migration[6.0]
  def change
  	remove_reference :orders, :product

  	add_reference :users, :shop
  	add_reference :products, :shop
  end
end
