class Unit < ApplicationRecord
  belongs_to :item, optional: true

  def price
  	item.price * base_units
  end
end
