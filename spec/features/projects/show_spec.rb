require 'rails_helper'

RSpec.describe 'project show page' do
    it 'shows the project name and material, and theme' do
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
        visit "/projects/#{news_chic.id}"

        expect(page).to have_content(news_chic.name)
        expect(page).to have_content(news_chic.material)
        expect(page).to have_content(recycled_material_challenge.theme)
        expect(page).to have_content("Number of Contestants: 2")
        expect(page).to have_content("Average Contestant Experience: 12.5")
    end

    it 'can add a contestant to project' do
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
        erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
        visit "/projects/#{news_chic.id}"
        fill_in "Add Contestant", with: "#{erin.id}"
        click_button "Add Contestant to Project"
        expect(current_path).to eq("/projects/#{news_chic.id}")  
        expect(page).to have_content("Number of Contestants: 3")
    end

end