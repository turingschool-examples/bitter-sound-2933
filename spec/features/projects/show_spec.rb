require 'rails_helper'

describe 'projects show page' do
  before do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end

  it "displays a projects name, material and theme" do
    visit "/projects/#{@boardfit.id}"

    expect(page).to have_content("Boardfit")
    expect(page).to have_content("Cardboard Boxes")
    expect(page).to have_content("Recycled Material")
    expect(page).to_not have_content("News Chic")
  end

  it "displays the number of contestants working on this project" do
    visit "/projects/#{@boardfit.id}"

    expect(page).to have_content("Number of Contestants: 2")

    visit "/projects/#{@upholstery_tux.id}"
    expect(page).to have_content("Number of Contestants: 1")

    visit "/projects/#{@news_chic.id}"
    expect(page).to have_content("Number of Contestants: 3")

  end

  it "displays the average years experience of all contestants on the project" do
    visit "/projects/#{@boardfit.id}"

    expect(page).to have_content("Average Contestant Experience: 11.5")

    visit "/projects/#{@upholstery_tux.id}"
    expect(page).to have_content("Average Contestant Experience: 12")

    visit "/projects/#{@news_chic.id}"
    expect(page).to have_content("Average Contestant Experience: 11")
  end

  it "allows me to add a contestant and redirects me to see the project page with an additional contestant" do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Number of Contestants: 3")

    fill_in "Contestant ID", with: "#{@erin.id}"
    click_button "Add Contestant to Project"

    expect(current_path).to eq("/projects/#{@news_chic.id}")
    expect(page).to have_content("Number of Contestants: 4")
  end
end
