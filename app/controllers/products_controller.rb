class ProductsController < ApplicationController
  def index
  	@products = Product.all

  	@products = Product.search(params[:q]) if params[:q]
  end

  def show
  	
  end
end
