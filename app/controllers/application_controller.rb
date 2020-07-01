class ApplicationController < ActionController::Base
	before_action :authenticate_user!, :set_locale, :set_tags, :params_to_flashes
	helper_method :current_cart

	# Seperate set logic from get logic 
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

	def params_to_flashes
		flash.now[:notice] = params[:flash_notice] if params[:flash_notice]
		flash.now[:alert] = params[:flash_alert] if params[:flash_alert]
	end
end
