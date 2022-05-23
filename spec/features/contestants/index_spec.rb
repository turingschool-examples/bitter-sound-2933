require 'rails_helper'


RSpec.describe "Contestants index page", type: :feature do
  let!(:recycled_material_challenge) { Challenge.create(theme: "Recycled Material", project_budget: 1000) }
  let!(:furniture_challenge) { Challenge.create(theme: "Apartment Furnishings", project_budget: 1000) }

  let!(:news_chic) { recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper") }
  let!(:boardfit) { recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes") }

  let!(:upholstery_tux) { furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch") }
  let!(:lit_fit) { furniture_challenge.projects.create(name: "Litfit", material: "Lamp") }

  let!(:jay) { Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13) }
  let!(:gretchen) { Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12) }
  let!(:kentaro) { Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8) }
  let!(:erin) { Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15) }

  before :each do
    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
    ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)
  end

  describe "User Story 2 of 3" do
    # As a visitor,
    # When I visit the contestants index page ("/contestants")
    # I see a list of names of all the contestants
    # And under each contestants name I see a list of the projects (names) that they've been on
    #
    # (e.g.   Kentaro Kameyama
    #         Projects: Litfit, Rug Tuxedo
    #
    #         Jay McCarroll
    #         Projects: LeatherFeather)
    it "shows the names of all contestants and the list of each contestant's projects" do
      visit "/contestants"

      expect(page).to have_content("Jay McCarroll")
      expect(page).to have_content("Gretchen Jones")
      expect(page).to have_content("Kentaro Kameyama")
      expect(page).to have_content("Erin Robertson")

      within "#contestant-#{gretchen.id}" do
        expect(page).to have_content("Projects: News Chic, Upholstery Tuxedo")
        expect(page).to_not have_content("Boardfit")
      end

      within "#contestant-#{kentaro.id}" do
        expect(page).to have_content("Projects: Upholstery Tuxedo, Boardfit")
        expect(page).to_not have_content("News Chic")
      end
    end
  end
end
