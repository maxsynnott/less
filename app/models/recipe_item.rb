class RecipeItem < ApplicationRecord
  belongs_to :unit
  belongs_to :recipe

  delegate :item, to: :unit, allow_nil: true
end
