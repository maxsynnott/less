class PhoneNumbersController < ApplicationController
	belongs_to :user

	validates :phone, phone: true
end
