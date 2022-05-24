require 'rails_helper'

RSpec.describe 'Projects Show' do
  it 'shows the projects name, material, and theme that the project belongs to' do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    visit "/projects/#{news_chic.id}"

    expect(page).to have_content(news_chic.name)
    expect(page).to have_content(news_chic.material)
    expect(page).to have_content(news_chic.challenge.theme)
  end

  it 'shows the number of contestants on this project' do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    jay = Contestant.create(name: "jay mccarroll", age: 40, hometown: "la", years_of_experience: 13)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
    ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
    ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

    visit "/projects/#{boardfit.id}"

    expect(page).to have_content("Number of Contestants: 2")
  end
end
