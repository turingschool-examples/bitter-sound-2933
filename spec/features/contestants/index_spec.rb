require 'rails_helper'

RSpec.describe "contestants#index" do
  describe "User Story 2" do
    # As a visitor,
    # When I visit the contestants index page ("/contestants")
    # I see a list of names of all the contestants
    # And under each contestants name I see a list of the projects (names) that they've been on

    it "displays a list of contestant names" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

      upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
      lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)


      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)

      visit "/contestants"

      expect(page).to have_content(jay.name)
      expect(page).to have_content(gretchen.name)
      expect(page).to have_content("News Chic")
      expect(page).to have_content("Upholstery Tuxedo")
      expect(page).to_not have_content("Litfit")
    end
  end

  describe "User Story Extension 2, contestants#index" do
    it "can add a contestant to a project" do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

      kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)

      visit "/contestants"

      expect(page).to have_content(jay.name)
      expect(page).to have_content(gretchen.name)
save_and_open_page
      within ("#contestant-#{kentaro.name}") do
        expect(page).to_not have_content(news_chic.name)
      end

      visit "/projects/#{news_chic.id}"

      expect(page).to have_content('Add Contestant to Project')
      fill_in 'contestant_by_id', with: "#{kentaro.id}"
      click_on 'Submit'

      visit '/contestants'

      within ("#contestant-#{kentaro.name}") do
        expect(page).to have_content(news_chic.name)
      end
    end
  end
end
