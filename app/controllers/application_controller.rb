class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :set_locale
	before_action :set_tags

	helper_method :current_cart

	def current_cart
		current_user.try(:cart)
	end

	def default_url_options
		{ locale: I18n.locale }
	end

	private

	def set_tags
		@tags = params[:search][:tags] if params[:search]
	end

	def set_locale
		locale = params[:locale].to_s.to_sym

	  I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
	end
end
