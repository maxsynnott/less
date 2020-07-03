class Unit < ApplicationRecord
  belongs_to :item, optional: true

  def price
  	item.price * base_units
  end

  def base?
  	base_units == 1
  end

  # On the fence, maybe bad practice but I am enjoying the convenience
  def to_s(count= nil)
  	if count.nil?
  		super()
  	else
  		I18n.t("unit.#{name}", count: count)
  	end
  end
end
