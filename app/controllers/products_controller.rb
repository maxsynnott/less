class ProductsController < ApplicationController
  before_action :assign_store

	skip_before_action :authenticate_user!, only: [:index]

  def index
    @products = @store.products

  	@products = @products.search(params[:q]) if params[:q].present?

  	@products = @products.paginate(page: params[:page], per_page: 12)
  end

  def show
  	@product = @store.products.find(params[:id])
  end

  def autocomplete
  	@products = @store.products.search(params[:q]).limit(5)

  	render layout: false
  end

  private

  def assign_store
    @store = Store.find(params[:store_id])
  end
end
