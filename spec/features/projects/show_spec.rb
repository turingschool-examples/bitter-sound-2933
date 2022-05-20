require 'rails_helper'

RSpec.describe "projects#show" do
  describe "User Story 1" do
    # As a visitor,
    # When I visit a project's show page ("/projects/:id"),
    # I see that project's name and material
    # And I also see the theme of the challenge that this project belongs to.
    it "displays a Projcets information" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

      news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

      visit "/projects/#{news_chic.id}"

      expect(page).to have_content("News Chic")
      expect(page).to have_content("Newspaper")
      expect(page).to_not have_content("Boardfit")
    end
  end
end
