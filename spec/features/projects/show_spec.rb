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

        it 'displays project contestant count' do
            recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
            furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
            news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
            lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
            jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
            gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
            kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
            ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
            ContestantProject.create(contestant_id: jay.id, project_id: lit_fit.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: lit_fit.id)
            ContestantProject.create(contestant_id: kentaro.id, project_id: lit_fit.id)
            visit "/projects/#{news_chic.id}"
            expect(page).to have_content("Contestant Count: 2")
            expect(page).to_not have_content("Contestant Count: 3")
        end
    end
    
end