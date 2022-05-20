require 'rails_helper'

RSpec.describe 'contestants#index' do
  it 'Displays list of all contestants names and their projects' do
    recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
    gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    visit '/contestants'
    within("#contestant-#{jay.id}") do
      expect(page).to have_content(jay.name)
      expect(page).to have_content(news_chic.name)
    end
    within("#contestant-#{gretchen.id}") do
      expect(page).to have_content(gretchen.name)
      expect(page).to have_content(news_chic.name)
    end
  end
end
