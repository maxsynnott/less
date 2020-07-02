class ChangeColumnNullToTrueOnUnitsItem < ActiveRecord::Migration[6.0]
  def change
  	change_column_null :units, :item_id, true
  end
end
