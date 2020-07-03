class ItemsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show, :autocomplete]

  def index
    @order_options = [
      ["Relevance", "relevance"],
      ["Price Ascending", "price_asc"],
      ["Price Descending", "price_desc"],
      ["Alphabetical", "alphabetical"]
    ]

    @items = Item.all

    search_items if params[:search].present?
    filter_items if params[:filter].present?
    order_items if params[:order].present?

    @item_count = @items.count # Neccessary to count before pagination when .paginate is called on array

  	@items = @items.paginate(page: params[:page], per_page: 24)
  end

  def show
  	@item = Item.find(params[:id])
  end

  def autocomplete
    @items = Item.all

  	search_items if params[:search].present?

    @items = @items.limit(5) unless @items.empty?

  	render layout: false
  end

  private

  def order_items
    order = params[:order]

    case order
    when "relevance"
      # Fancy order
    when "price_asc"
      @items = @items.sort_by(&:display_price)
    when "price_desc"
      @items = @items.sort_by(&:display_price).reverse
    when "alphabetical"
      @items.reorder!(name: :asc)
    end
  end

  def search_items
    @items = @items.search(params[:search])
  end

  def filter_items
    params[:filter].each do |filter|
      @items = @items.tagged_with(filter) unless filter.blank?
    end
  end
end
