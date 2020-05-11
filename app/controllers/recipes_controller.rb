class RecipesController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]

	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)

		@recipe.save

		redirect_to recipes_path
	end

	def like
		@recipe = Recipe.find(params[:id])

		current_user.liked?(@recipe) ? current_user.unlike(@recipe) : current_user.likes(@recipe)
	end

	def add_to_cart
		@recipe = Recipe.find(params[:id])

		@recipe.add_to_cart(current_user.cart)
	end

	private

	def recipe_params
		params.require(:recipe).permit(:name, :description, :public, :information, :image)
	end
end
