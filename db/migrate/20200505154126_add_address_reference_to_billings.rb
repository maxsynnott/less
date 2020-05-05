class AddAddressReferenceToBillings < ActiveRecord::Migration[6.0]
  def change
    add_reference :billings, :address, foreign_key: true
  end
end
