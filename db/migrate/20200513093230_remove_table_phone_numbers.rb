class RemoveTablePhoneNumbers < ActiveRecord::Migration[6.0]
  def up
  	drop_table :phone_numbers
  end

  def down
  	
  end
end
