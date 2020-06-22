class ApplicationController < ActionController::Base
	before_action :authenticate_user!, :set_locale, :set_tags
	helper_method :current_cart

	def current_cart
		if current_user
			current_user.cart
		elsif session[:cart_id] and (cart = Cart.find_by_id(session[:cart_id])) and cart.user_id.nil?
			cart
		else
			cart = Cart.create
			session[:cart_id] = cart.id
			
			cart
		end
	end

	def default_url_options
		{ locale: I18n.locale }
	end

	private

	# Remove and replace this at some point
	def set_tags
		@tags = params[:filter]
	end

	def set_locale
		I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
		session[:locale] = I18n.locale
	end

	def authenticate_admin!
		redirect_to new_user_session_path unless current_user.try(:admin?)
	end
end
