class RenameShopsAsStores < ActiveRecord::Migration[6.0]
  def change
  	rename_table :shops, :stores
  end
end
