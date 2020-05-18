class ProductsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]

  def index
  	@products = Product.paginate(page: params[:page], per_page: 12)
  end
end
