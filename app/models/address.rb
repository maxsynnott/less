class Address < ApplicationRecord
	belongs_to :user

	has_many :deliveries
end
