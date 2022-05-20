require 'rails_helper'

RSpec.describe 'projects#show', type: :feature do
  it 'Displays the project name, material, and challenge theme' do
    recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    visit "/projects/#{news_chic[:id]}"
    expect(page).to have_content(news_chic.name)
    expect(page).to have_content(news_chic.material)
    expect(page).to have_content(recycled_material_challenge.theme)
  end

  it 'Displays the number of contestants for the project' do
    recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
    gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    visit "/projects/#{news_chic[:id]}"
    expect(page).to have_content('Number of Contestants: 2')
  end

  it 'Displays the average years of experience of the contestants that participated' do
    recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
    gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    visit "/projects/#{news_chic[:id]}"
    expect(page).to have_content('Average Contestant Experience: 12.5')
  end

  it 'has a form to add a contestant to the project' do
    recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
    gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
    bryce = Contestant.create(name: 'Bryce Wein', age: 29, hometown: 'Gulf Breeze', years_of_experience: 29)
    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    visit "/projects/#{news_chic[:id]}"
    expect(page).to have_content('Number of Contestants: 2')
    expect(page).to have_field('contestant_id')
    fill_in 'contestant_id', with: bryce.id
    click_on 'Add Contestant To Project'
    expect(current_path).to eq("/projects/#{news_chic[:id]}")
    expect(page).to have_content('Number of Contestants: 3')
    visit '/contestants'
    within("#contestant-#{bryce.id}") do
      expect(page).to have_content(news_chic.name)
    end
  end
end
