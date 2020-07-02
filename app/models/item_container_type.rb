class ItemContainerType < ApplicationRecord
  belongs_to :item
  belongs_to :container_type
end
