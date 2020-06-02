class DropTableBillings < ActiveRecord::Migration[6.0]
  def change
  	remove_reference :orders, :billing
  	drop_table :billings
  end
end
