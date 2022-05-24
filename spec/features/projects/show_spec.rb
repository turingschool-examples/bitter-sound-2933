require 'rails_helper'

RSpec.describe Project, type: :feature do
  context 'visitors to show page' do
    it 'will see the project name, materials, and theme' do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

    visit "/projects/#{news_chic.id}"

    expect(page).to have_content("News Chic")
    expect(page).to have_content("Materials: Newspaper")
    expect(page).to have_content("Materials: Newspaper")
    expect(page).to have_content("Theme: Recycled Material")
    end

    it 'will see the number of contestants on the project' do
      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)

      visit "/projects/#{news_chic.id}"

      expect(page).to have_content('Number of Contestants: 2')
    end
  end
end