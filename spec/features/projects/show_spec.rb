require 'spec_helper'

RSpec.describe 'projects show page', type: :feature do
  it 'can see project info' do
    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    visit("/projects/#{lit_fit.id}")

    expect(page).to have_content("Litfit")
    expect(page).to have_content("Material: Lamp")
    expect(page).to have_content("Challenge Theme: Apartment Furnishings")
  end

  it 'can count the number of contestants on project' do

  recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

  news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
  boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

  jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
  gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
  kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
  erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


  ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
  ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
  ContestantProject.create(contestant_id: kentaro.id, project_id: news_chic.id)

  visit("/projects/#{news_chic.id}")
  expect(page).to have_content("Number of Contestants: 3")
  end

  it 'can get the average years of experience of contestants on project' do

  recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

  news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
  boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

  jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
  gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
  kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
  erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


  ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
  ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
  ContestantProject.create(contestant_id: kentaro.id, project_id: news_chic.id)

  visit("/projects/#{news_chic.id}")
  expect(page).to have_content("Average Contestant Experience: 11")
  end
end
