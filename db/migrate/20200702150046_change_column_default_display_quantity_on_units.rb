class ChangeColumnDefaultDisplayQuantityOnUnits < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :items, :display_quantity, 1
  end
end
