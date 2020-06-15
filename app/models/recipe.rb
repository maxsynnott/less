class Recipe < ApplicationRecord
  # cacheable_strategy: :update_columns prevents votes from changing the recipe's updated_at column
	acts_as_votable cacheable_strategy: :update_columns

	has_rich_text :information

	has_one_attached :image

  belongs_to :user, optional: true

  has_many :recipe_items

  default_scope { where(public: true) }

  validates_presence_of :name

  def add_to_cart(cart)
  	recipe_items.each { |recipe_item| cart.add_item(recipe_item.item, recipe_item.quantity) }
  end
end
