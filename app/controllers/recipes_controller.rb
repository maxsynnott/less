class RecipesController < ApplicationController
	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def add_to_cart
		@recipe = Recipe.find(params[:id])

		@recipe.add_to_cart(current_user.cart)
	end
end
