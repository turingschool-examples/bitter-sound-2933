# User Story 1 of 3
#
# As a visitor,
# When I visit a project's show page ("/projects/:id"),
# I see that project's name and material
# And I also see the theme of the challenge that this project belongs to.
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings)

require 'rails_helper'

RSpec.describe Project, type: :feature do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
  end

  it 'displays the projects name and material on the show page' do
    visit ("/projects/#{@news_chic.id}")
    save_and_open_page
    expect(page).to have_content('News Chic')
    expect(page).to have_content('Newspaper')
    expect(page).to have_content('Recycled Material')
  end

  # User Story 3 of 3
  # As a visitor,
  # When I visit a project's show page
  # I see a count of the number of contestants on this project
  #
  # (e.g.    Litfit
  #   Material: Lamp Shade
  #   Challenge Theme: Apartment Furnishings
  #   Number of Contestants: 3 )
  # it 'displays the number of contestants on a project' do
  #   visit ("/projects/#{@news_chic.id}")
  # end
end
