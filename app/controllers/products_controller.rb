class ProductsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]

  def index
  	@products = params[:q] ? Product.search(params[:q]) : Product.all

  	@products = @products.paginate(page: params[:page], per_page: 12)
  end
end
