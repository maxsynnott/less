class RenameTokenToSessionIdOnBillings < ActiveRecord::Migration[6.0]
  def change
  	rename_column :billings, :token, :stripe_id
  end
end
