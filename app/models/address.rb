class Address < ApplicationRecord
	has_one :store

	validates_presence_of :line_1, :postal_code, :country
end
