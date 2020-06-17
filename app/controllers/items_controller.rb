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

    filter_items if params[:search].present?
    order_items if params[:order].present?

  	@items = @items.paginate(page: params[:page], per_page: 24)
  end

  def show
  	@item = Item.find(params[:id])
  end

  def autocomplete
    @items = Item.all

  	filter_items if params[:search].present?

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
      @items.reorder!(price: :asc)
    when "price_desc"
      @items.reorder!(price: :desc)
    when "alphabetical"
      @items.reorder!(name: :asc)
    end
  end

  def filter_items
    search = params[:search]

    # Clean this up, was just a temp hack to have autocomplete clear on empty string
    if !search[:tags] and search[:query].blank?
      @items = []
    else
      @items = @items.search(search[:query]) if search[:query].present?

      if search[:tags]
        search[:tags].each do |tag|
          @items = @items.tagged_with(tag) unless tag.blank?
        end
      end
    end
  end
end
