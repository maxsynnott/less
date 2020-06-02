class RenamingColumns < ActiveRecord::Migration[6.0]
  def change
  	rename_column :products, :shop_id, :store_id
  	rename_column :users, :shop_id, :store_id
  end
end
