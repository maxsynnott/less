class Unit < ApplicationRecord
  belongs_to :item, optional: true

  def price
  	item.price * base_units
  end

  def base?
  	base_units == 1
  end
end
