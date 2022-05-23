require 'rails_helper'

RSpec.describe 'Projects show page', type: :feature do
  it 'shows an individual projects name, materials and theme from the challenge' do
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    visit "/projects/#{news_chic.id}"

    expect(page).to have_content(news_chic.name)
    expect(page).to have_content("Material: #{news_chic.material}")
    expect(page).to have_content("Challenge Theme: #{recycled_material_challenge.theme}")
    expect(page).to_not have_content(boardfit.name)
    expect(page).to_not have_content("Material: #{boardfit.material}")
  end
end
