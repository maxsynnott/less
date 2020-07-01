require 'rails_helper'

RSpec.feature "User searches for items", js: true do
	before do
		@user = create(:user)

		login_as @user, scope: :user
	end

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
				context "with existing filters" do
					scenario "they are redirected to items path with correct items ignoring filters" do
						Item.find_by_name("Rice Flour").update(tag_list: ["Personal Care"])
						click_on "Personal Care"

						expect(page).to have_current_path(items_path(locale: :en, filter: ["Personal Care"]))

						sleep 0.5

						fill_in "desktop_search_field", with: "Flour"

						expect(page).to have_css ".autocomplete-link", count: 2

						expect(page).to have_css ".autocomplete-link", text: "Rice Flour"
						expect(page).to have_css ".autocomplete-link", text: "Flour"

						find("#desktop_search_field + div button").click

						expect(page).to have_css ".card-title", count: 2
						expect(page).to have_css ".card-title", text: "Rice Flour"
						expect(page).to have_css ".card-title", text: "Flour"

						expect(current_path).to end_with items_path
					end
				end

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

		context "they enter an invalid query" do
			before do
				visit items_path

				fill_in "desktop_search_field", with: "Nonsense"
			end

			context "they submit search" do
				scenario "they are redirected to items path with no items" do
					expect(page).to_not have_css ".autocomplete-link"
					expect(page).to have_content "No items found"

					find("#desktop_search_field + div button").click

					expect(current_path).to end_with items_path

					expect(page).to have_content "No items found"
					expect(page).to_not have_css ".card-title"
				end
			end
		end

		context "they don't enter a query", js: false do
			before do
				visit items_path
			end

			context "they submit search" do
				scenario "they are redirected to items path with all items" do
					find("#desktop_search_field + div button").click

					expect(page).to have_current_path(items_path(locale: :en, search: ''))

					expect(page).to have_css ".card-title", count: 3
				end
			end
		end
	end

	context "there are no created items" do
		context "they don't enter a query", js: false do
			context "they submit search" do
				scenario "they are redirected to items path with no items" do
					visit items_path

					find("#desktop_search_field + div button").click

					expect(page).to have_current_path(items_path(locale: :en, search: ''))

					expect(page).to_not have_css ".card-title"
					expect(page).to have_content "No items found"
				end
			end
		end
	end
end
