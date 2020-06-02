class DropTableBillings < ActiveRecord::Migration[6.0]
  def change
  	drop_table :billings
  end
end
