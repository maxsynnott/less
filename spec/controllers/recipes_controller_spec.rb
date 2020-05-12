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
