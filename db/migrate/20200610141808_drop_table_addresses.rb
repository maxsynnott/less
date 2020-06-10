class DropTableAddresses < ActiveRecord::Migration[6.0]
  def change
  	remove_column :stores, :address_id
  	drop_table :addresses
  end
end
