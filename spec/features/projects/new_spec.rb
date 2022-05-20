require 'rails_helper'

RSpec.describe "Adding a new contestant from project show page" do
    describe "project show page has a link that allows you to add new contestant" do
        it "has a link that takes user to form to add new contestant if contestant id exists" do
            recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
            news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
            jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
            gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
            kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
            ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
            visit "/projects/#{news_chic.id}"
            expect(page).to have_content("Contestant Count: 2") 
            click_link "Add New Contestant"
            fill_in :add_new, with: "#{kentaro.id}"
            click_button 'Add Contestant To Project'
            expect(current_path).to eq("/projects/#{news_chic.id}") 
            expect(page).to have_content("Contestant Count: 3")

            visit "/contestants"
            within "#contestant-#{kentaro.id}" do
                expect(page).to have_content("News Chic")
            end
        end
        
    end
end
