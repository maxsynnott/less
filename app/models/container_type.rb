class ContainerType < ApplicationRecord
	has_many :item_container_types, dependent: :destroy
	has_many :items, through: :item_container_types

	has_many :containers
end
