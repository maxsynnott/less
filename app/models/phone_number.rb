class PhoneNumber < ApplicationRecord
  belongs_to :user

	validates :number, phone: true

	validates_presence_of :user, :number
end
