class Address < ApplicationRecord
	has_many :deliveries

	validates_presence_of :line_1, :postal_code, :country
end
