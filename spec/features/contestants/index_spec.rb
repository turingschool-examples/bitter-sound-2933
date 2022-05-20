require 'rails_helper'

RSpec.describe "Contestant Index Page", type: :feature do
    describe "when I visit contestant index page" do
        it 'displays list of names for all contestants and their proejcts' do
            recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
            furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
            news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
            boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
            upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
            lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
            jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
            gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
            kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
            ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
            ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
            ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
            visit "/contestants"
            within "#contestant-#{jay.id}" do
                expect(page).to have_content("Name: Jay McCarroll")
                expect(page).to have_content("News Chic")
                expect(page).to_not have_content("Name: Gretchen Jones")
                expect(page).to_not have_content("Boardfit")
            end
            within "#contestant-#{gretchen.id}" do
                expect(page).to have_content("Name: Gretchen Jones")
                expect(page).to have_content("News Chic")
                expect(page).to have_content("Upholstery Tuxedo")
                expect(page).to_not have_content("Name: Jay McCarroll")
                expect(page).to_not have_content("Boardfit")
            end
            within "#contestant-#{kentaro.id}" do
                expect(page).to have_content("Name: Kentaro Kameyama")
                expect(page).to have_content("Upholstery Tuxedo")
                expect(page).to have_content("Boardfit")
                expect(page).to_not have_content("Name: Gretchen Jones")
                expect(page).to_not have_content("News Chic")
            end
        end
    end
    
end