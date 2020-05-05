class RenameHouseNumberToLine2OnAddresses < ActiveRecord::Migration[6.0]
  def change
  	rename_column :addresses, :house_number, :line_2
  end
end
