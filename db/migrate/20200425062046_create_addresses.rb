class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :house_number
      t.string :recipient
      t.string :postal_code
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
