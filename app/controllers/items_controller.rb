class ItemsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]

  def index
    @items = Item.all

    filter_items if params[:search].present?

  	@items = @items.paginate(page: params[:page], per_page: 12)
  end

  def show
  	@item = Item.find(params[:id])
  end

  def autocomplete
    @items = Item.all

  	filter_items if params[:search].present?

    @items = @items.limit(5)

  	render layout: false
  end

  private

  def filter_items
    search = params[:search]

    @items = @items.search(search[:query]) if search[:query].present?

    if search[:tags]
      search[:tags].each do |tag|
        @items = @items.tagged_with(tag) unless tag.blank?
      end
    end
  end
end
