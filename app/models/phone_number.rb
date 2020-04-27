class PhoneNumber < ApplicationRecord
  belongs_to :user

	validates :phone, phone: true
end
