require 'rails_helper'

RSpec.describe "contestants index page" do
  it "lists all the contestants and their associated projects" do
    # ContestantProject.destroy_all
    # Contestant.destroy_all
    # Project.destroy_all
    # Challenge.destroy_all
    recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
    ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

    visit "/contestants"

    # within("div#contestant-#{jay.id}") do
      expect(page).to have_content("Jay McCarroll")
      expect(page).to have_content("News Chic")
      # expect(page).to_not have_content("Kentaro Kameyama")
      # expect(page).to_not have_content("Litfit")
    # end

    # within("div#contestant-#{gretchen.id}") do
      expect(page).to have_content("Gretchen Jones")
      expect(page).to have_content("News Chic")
      expect(page).to have_content("Upholstery Tuxedo")
      # expect(page).to_not have_content("Jay McCarroll")
      # expect(page).to_not have_content("Boardfit")
    # end
      expect(page).to_not have_content("Recycled Material")
      expect(page).to_not have_content("Apartment Furnishings")
  end
end
