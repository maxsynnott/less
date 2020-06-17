class ItemsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show, :autocomplete]

  def index
    @sort_options = [
      ["Relevance", "relevance"],
      ["Price Ascending", "price_asc"],
      ["Price Descending", "price_desc"],
      ["Alphabetical", "alphabetical"]
    ]

    @items = Item.all

    filter_items if params[:search].present?
    sort_items if params[:sort].present?

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

  def sort_items
    sort = params[:sort]

    binding.pry

    case sort
    when "relevance"
      # Fancy sort
    when "price_asc"
      @items.order!(price: :asc)
    when "price_desc"
      @items.order!(price: :desc)
    when "alphabetical"
      @items.order!(name: :asc)
    end

    p @items
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
