class ProductsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]

  def index
  	@products = params[:q] ? Product.search(params[:q]) : Product.all

  	@products = @products.paginate(page: params[:page], per_page: 12)
  end

  def show
  	@product = Product.find(params[:id])
  end

  def autocomplete
  	@products = Product.search(params[:q]).limit(5)

  	render layout: false
  end
end
