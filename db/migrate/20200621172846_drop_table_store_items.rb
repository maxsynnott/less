class DropTableStoreItems < ActiveRecord::Migration[6.0]
  def change
  	drop_table :store_items
  end
end
