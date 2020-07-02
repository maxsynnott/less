class ItemContainer < ApplicationRecord
  belongs_to :item
  belongs_to :container
end
