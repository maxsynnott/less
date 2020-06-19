class ApplicationController < ActionController::Base
	before_action :authenticate_user!, :set_locale, :set_tags
	helper_method :current_cart

	def current_cart
		if current_user
			current_user.cart
		elsif session[:cart_id] and (cart = Cart.find(session[:cart_id])) and cart.user_id.nil?
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
		locale = params[:locale].to_s.to_sym

	  I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
	end
end
