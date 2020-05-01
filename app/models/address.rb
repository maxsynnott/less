class Address < ApplicationRecord
	belongs_to :user

	has_many :deliveries

	validates_presence_of :street, :house_number, :postal_code, :country, :user
end
