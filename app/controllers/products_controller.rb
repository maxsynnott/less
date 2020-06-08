class ProductsController < ApplicationController
  before_action :assign_store

	skip_before_action :authenticate_user!, only: [:index]

  def index
    @products = @store.products

    filter_products if params[:search].present?

  	@products = @products.paginate(page: params[:page], per_page: 12)
  end

  def show
  	@product = @store.products.find(params[:id])
  end

  def autocomplete
    @products = @store.products

  	filter_products if params[:search].present?

    @products = @products.limit(5)

  	render layout: false
  end

  private

  def filter_products
    search = params[:search]

    @products = @products.search(search[:query]) if search[:query].present?

    if search[:tags].count > 1
      search[:tags][1..-1].each do |tag|
        @products = @products.tagged_with(tag)
      end
    end
  end

  def assign_store
    @store = Store.find(params[:store_id])
  end
end
