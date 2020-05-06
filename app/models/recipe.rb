class Recipe < ApplicationRecord
  belongs_to :user, optional: true

  has_many :recipe_items

  default_scope { where(public: true) }

  def add_to_cart(cart)
  	recipe_items.each { |recipe_item| cart.add_product(recipe_item.product, recipe_item.quantity) }
  end
end
