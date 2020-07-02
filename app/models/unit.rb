class Unit < ApplicationRecord
  belongs_to :item

  def price
  	item.price * base_units
  end
end
