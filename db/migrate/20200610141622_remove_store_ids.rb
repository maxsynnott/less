class RemoveStoreIds < ActiveRecord::Migration[6.0]
  def change
  	remove_column :users, :store_id
  	remove_column :items, :store_id
  end
end
