require "rails_helper"

RSpec.describe "project page" do
  before :each do
    #Challenges
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
    #projects
    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
    #Contestants
    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
    #contestant projects
    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end

  it "shows project name, material, and theme" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("News Chic")
    expect(page).to have_content("Newspaper")
    expect(page).to have_content("Recycled Material")
  end

  it "shows number of contestants" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Number of Contestants: 2")
    visit "/projects/#{@upholstery_tux.id}"

    expect(page).to have_content("Number of Contestants: 2")
    visit "/projects/#{@boardfit.id}"

    expect(page).to have_content("Number of Contestants: 2")
  end

  it "can add contestants" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_link("Add Contestant To Project")

    fill_in :name, with: "Colin Reinhart"
    fill_in :age, with: 33
    fill_in :hometown, with: "Denver"
    fill_in :years_of_experience, with: 1
    click_button "Add Contestant To Project"
    expect(file_path).to eq("/projects/#{@news_chic.id}")
    expect(page).to have_content("Number of Contestants: 3")

    visit "/contestants"

    within "##{@contestant.last.id}"
      expect(page).to have_content("Colin Reinhart")
      expect(page).to have_content("Projects: News Chic")
    end
  end

end
