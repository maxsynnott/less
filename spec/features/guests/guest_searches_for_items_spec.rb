require 'rails_helper'

RSpec.feature "Guest searches for items", js: true do
	context "there are created items" do
		before do
			create(:item, name: "Flour")
			create(:item, name: "Rice")
			create(:item, name: "Rice Flour")
		end

		context "they enter a valid query" do
			before do
				visit items_path

				fill_in "desktop_search_field", with: "Flour"
			end

			context "they click on a specific item" do
				scenario "they are redirected to the items show page" do
					expect(page).to have_css ".autocomplete-link", count: 2
					expect(page).to have_css ".autocomplete-link", text: "Rice Flour"
					expect(page).to have_css ".autocomplete-link", text: "Flour"
				
					find(".autocomplete-link", text: "Rice Flour").click

					expect(page).to have_css ".card-title", count: 1
					expect(page).to have_css ".card-title", text: "Rice Flour"

					expect(current_path).to end_with item_path(id: Item.last.id)
				end
			end

			context "they submit search" do
				context "without existing filters" do
					scenario "they are redirected to items path with correct items" do
						find("#desktop_search_field + div button").click

						expect(page).to have_css ".card-title", count: 2
						expect(page).to have_css ".card-title", text: "Rice Flour"
						expect(page).to have_css ".card-title", text: "Flour"

						expect(current_path).to end_with items_path
					end
				end
			end
		end
	end
end