class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	helper_method :current_cart

	def current_cart
		current_user.try(:cart)
	end
end
