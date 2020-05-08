class RemoveExpiresAtFromStocks < ActiveRecord::Migration[6.0]
  def change
    remove_column :stocks, :expires_at, :datetime
  end
end
