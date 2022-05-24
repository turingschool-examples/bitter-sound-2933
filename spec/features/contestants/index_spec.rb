require "rails_helper"

RSpec.describe 'Contestamts Index Page' do
  let!(:recycled_material_challenge) { Challenge.create!(theme: "Recycled Material", project_budget: 1000) }
  let!(:furniture_challenge) { Challenge.create!(theme: "Apartment Furnishings", project_budget: 1000) }

  let!(:news_chic) { recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper") }
  let!(:boardfit) { recycled_material_challenge.projects.create!(name: "Boardfit", material: "Cardboard Boxes") }

  let!(:upholstery_tux) { furniture_challenge.projects.create!(name: "Upholstery Tuxedo", material: "Couch") }
  let!(:lit_fit) { furniture_challenge.projects.create!(name: "Litfit", material: "Lamp") }

  it "lists contestants and their projects" do
    jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)

    visit '/contestants'

    expect(page).to have_content("Jay McCarroll")
    expect(page).to have_content("News Chic")
    expect(page).to have_content("Kentaro Kameyama")
    expect(page).to have_content("Upholstery Tuxedo")
    expect(page).to have_content("Boardfit")
    expect(page).to_not have_content("Litfit")
  end
end
