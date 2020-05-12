require 'rails_helper'

RSpec.describe RecipesController, "#index" do
	before do 
		sign_in create(:user)
		2.times { create(:recipe) }
	end

	it "assigns :recipes and renders :index" do
		get :index

		expect(assigns(:recipes)).to all be_an_instance_of Recipe

		expect(response).to render_template(:index)
	end
end

RSpec.describe RecipesController, "#show" do
	before { sign_in create(:user) }
	let(:recipe) { create(:recipe) }

	it "assigns :recipe and renders :show" do
		get :show, params: { id: recipe.id }

		expect(assigns(:recipe)).to eq recipe

		expect(response).to render_template(:show)
	end
end

RSpec.describe RecipesController, "#new" do
	before { sign_in create(:user) }

	it "assigns :recipe and renders :new" do
		get :new

		expect(assigns(:recipe)).to be_a_new Recipe

		expect(response).to render_template(:new)
	end
end

RSpec.describe RecipesController, "#create" do
	before { sign_in create(:user) }

	context "when provided with valid params" do
		let(:valid_params) { { recipe: { name: "Roast Chicken", description: "yum" } } }

		it "creates the recipe and redirects to recipes_path" do
			post :create, params: valid_params

			expect(assigns(:recipe)).to be_an_instance_of Recipe
			expect(assigns(:recipe)).to have_attributes(
				name: "Roast Chicken",
				description: "yum"
			)

			expect(response).to redirect_to recipes_path
		end
	end

	context "when provided with invalid params" do
		let(:invalid_params) { { recipe: { name: nil, description: "yum" } } }

		it "doesn't create the recipe and renders :new" do
			post :create, params: invalid_params

			expect(assigns(:recipe)).to be_a_new Recipe

			expect(response).to render_template :new
		end
	end
end

RSpec.describe RecipesController, "#toggle_like" do
	before { sign_in create(:user) }
	let(:recipe) { create(:recipe) }
	let(:user) { controller.current_user }

	context "JS" do
		context "when the user has already liked the recipe" do
			before { user.likes(recipe) }

			it "assigns :recipe, decreases likes and renders :toggle_like" do
				expect(recipe.get_likes.length).to eq 1

				post :toggle_like, xhr: true, params: { id: recipe.id }

				recipe.reload

				expect(assigns(:recipe)).to eq recipe
				expect(recipe.get_likes.length).to eq 0

				expect(response).to render_template(:toggle_like)
			end
		end

		context "when the user has not already liked the recipe" do
			it "assigns :recipe, increases likes and renders :toggle_like" do
				expect(recipe.get_likes.length).to eq 0

				post :toggle_like, xhr: true, params: { id: recipe.id }

				recipe.reload

				expect(assigns(:recipe)).to eq recipe
				expect(recipe.get_likes.length).to eq 1

				expect(response).to render_template(:toggle_like)
			end
		end
	end
end

RSpec.describe RecipesController, "#add_to_cart" do
	before { sign_in create(:user) }
	let(:user) { controller.current_user }
	let(:recipe) { create(:recipe, :with_recipe_items) }

	context "JS" do
		it "assigns :recipe and adds all items to cart" do
			post :add_to_cart, xhr: true, params: { id: recipe.id }

			user.reload
			recipe.reload

			expect(assigns(:recipe)).to eq recipe
			expect(user.cart.cart_items.map { |ci| [ci.product, ci.quantity] }).to eq recipe.recipe_items.map { |ri| [ri.product, ri.quantity] }

			expect(response).to render_template(:add_to_cart)
		end
	end
end
