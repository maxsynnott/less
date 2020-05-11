class ProductsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]

  def index
  	@products = Product.all

  	@products = Product.search(params[:q]) if params[:q]
  end
end
