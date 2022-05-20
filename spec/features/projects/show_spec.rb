require 'rails_helper'

RSpec.describe "Project Show Page", type: :feature do
    describe "when I visit project show page" do
        it 'displays project name, material and the theme of the challenge it belongs to' do
            recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
            news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
            boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
            visit "/projects/#{news_chic.id}"
            expect(page).to have_content("Project Name: News Chic")
            expect(page).to have_content("Material: Newspaper")
            expect(page).to have_content("Challenge Theme: Recycled Material")
            expect(page).to_not have_content("Project Name: Boardfit")
            expect(page).to_not have_content("Material: Cardboard Boxes")
        end
    end
    
end