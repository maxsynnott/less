class RecipesController < ApplicationController
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

	def add_to_cart
		@recipe = Recipe.find(params[:id])

		@recipe.add_to_cart(current_user.cart)
	end

	def recipe_params
		params.require(:recipe).permit(:name, :description, :boolean)
	end
end
