class RenameStreetToLine1OnAddresses < ActiveRecord::Migration[6.0]
  def change
  	rename_column :addresses, :street, :line_1
  end
end
