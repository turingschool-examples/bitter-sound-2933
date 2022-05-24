require "rails_helper"

RSpec.describe 'Projects Index Page' do
    let!(:recycled_material_challenge) { Challenge.create!(theme: "Recycled Material", project_budget: 1000) }
    let!(:furniture_challenge) { Challenge.create!(theme: "Apartment Furnishings", project_budget: 1000) }

    let!(:news_chic) { recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper") }
    let!(:boardfit) { recycled_material_challenge.projects.create!(name: "Boardfit", material: "Cardboard Boxes") }

    let!(:upholstery_tux) { furniture_challenge.projects.create!(name: "Upholstery Tuxedo", material: "Couch") }
    let!(:lit_fit) { furniture_challenge.projects.create!(name: "Litfit", material: "Lamp") }


  it "lists projects" do
    visit "/projects"

    expect(page).to have_content(news_chic.name)
    expect(page).to have_content(boardfit.name)
    expect(page).to have_content(upholstery_tux.name)
    expect(page).to have_content(lit_fit.name)
  end
end
