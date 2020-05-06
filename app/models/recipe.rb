class Recipe < ApplicationRecord
  belongs_to :user, optional: true

  has_many :recipe_items

  default_scope { where(public: true) }
end
