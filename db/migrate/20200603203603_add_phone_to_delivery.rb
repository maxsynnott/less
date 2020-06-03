class AddPhoneToDelivery < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :phone, :string
  end
end
