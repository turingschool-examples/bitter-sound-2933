require 'rails_helper'


RSpec.describe "Projects show page", type: :feature do
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

  describe "User Story 1 of 3" do
    # As a visitor,
    # When I visit a project's show page ("/projects/:id"),
    # I see that project's name and material
    # And I also see the theme of the challenge that this project belongs to.
    # (e.g.    Litfit
    #   Material: Lamp Shade
    #   Challenge Theme: Apartment Furnishings)
    it "shows the project's name, material, and challenge theme" do
      visit "/projects/#{news_chic.id}"

      expect(page).to have_content("Project Name: News Chic")
      expect(page).to have_content("Material: Newspaper")
      expect(page).to have_content("Challenge Theme: Recycled Material")

      expect(page).to_not have_content("Boardfit")
      expect(page).to_not have_content("Upholstery Tuxedo")
      expect(page).to_not have_content("Apartment Furnishings")

      visit "/projects/#{upholstery_tux.id}"

      expect(page).to have_content("Project Name: Upholstery Tuxedo")
      expect(page).to have_content("Material: Couch")
      expect(page).to have_content("Challenge Theme: Apartment Furnishings")

      expect(page).to_not have_content("News Chic")
      expect(page).to_not have_content("Newspaper")
      expect(page).to_not have_content("Recycled Material")
    end
  end

  describe "User Story 3 of 3" do
    # As a visitor,
    # When I visit a project's show page
    # I see a count of the number of contestants on this project
    #
    # (e.g.    Litfit
    #     Material: Lamp Shade
    #   Challenge Theme: Apartment Furnishings
    #   Number of Contestants: 3 )
    it "has a count of the number of contestants on this project" do
      visit "/projects/#{news_chic.id}"
      expect(page).to have_content("Number of Contestants: 2")

      visit "/projects/#{boardfit.id}"
      expect(page).to have_content("Number of Contestants: 2")

      visit "/projects/#{upholstery_tux.id}"
      expect(page).to have_content("Number of Contestants: 2")

      visit "/projects/#{lit_fit.id}"
      expect(page).to have_content("Number of Contestants: 0")
    end
  end

  describe "User Story Extension 1 - Average years of experience for contestants by project" do
    # As a visitor,
    # When I visit a project's show page
    # I see the average years of experience for the contestants that worked on that project
    # (e.g.    Litfit
    #     Material: Lamp Shade
    #   Challenge Theme: Apartment Furnishings
    #   Number of Contestants: 3
    #   Average Contestant Experience: 10.25 years)
    it "shows the average years of experience for the contestants that worked on that project" do
      ContestantProject.create(contestant_id: jay.id, project_id: upholstery_tux.id)
      ContestantProject.create(contestant_id: erin.id, project_id: upholstery_tux.id)

      visit "/projects/#{news_chic.id}"
      expect(page).to have_content("Average Contestant Experience: 12.5 years")

      visit "/projects/#{boardfit.id}"
      expect(page).to have_content("Average Contestant Experience: 11.5 years")

      visit "/projects/#{upholstery_tux.id}"
      expect(page).to have_content("Average Contestant Experience: 12.0 years")

      visit "/projects/#{lit_fit.id}"
      expect(page).to have_content("Average Contestant Experience: 0.0 years")
    end
  end

  describe "User Story Extension 2 - Adding a contestant to a project" do
    # As a visitor,
    # When I visit a project's show page
    # I see a form to add a contestant to this project
    # When I fill out a field with an existing contestants id
    # And hit "Add Contestant To Project"
    # I'm taken back to the project's show page
    # And I see that the number of contestants has increased by 1
    # And when I visit the contestants index page
    # I see that project listed under that contestant's name
    it "can add a contestant to the project" do
      visit "/contestants"

      within "#contestant-#{jay.id}" do
        expect(page).to_not have_content("Litfit")
      end

      visit "/projects/#{lit_fit.id}"

      expect(page).to have_content("Number of Contestants: 0")

      fill_in :add_contestant, with: jay.id
      click_button "Add Contestant To Project"

      expect(current_path).to eq("/projects/#{lit_fit.id}")
      expect(page).to have_content("Number of Contestants: 1")

      visit "/contestants"

      within "#contestant-#{jay.id}" do
        expect(page).to have_content("Litfit")
      end
    end
  end
end
