class RemoveAddressFromBillings < ActiveRecord::Migration[6.0]
  def change
    remove_reference :billings, :address, null: false, foreign_key: true
  end
end
