require 'rails_helper'

RSpec.describe 'Projects show page', type: :feature do
  before(:each) do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end
  it 'shows an individual projects name, materials and theme from the challenge' do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content(@news_chic.name)
    expect(page).to have_content("Material: #{@news_chic.material}")
    expect(page).to have_content("Challenge Theme: #{@recycled_material_challenge.theme}")
    expect(page).to_not have_content(@boardfit.name)
    expect(page).to_not have_content("Material: #{@boardfit.material}")
  end

  it 'can display how many contestants worked on the project' do

    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Number of Contestants: 2")
    expect(page).to have_content("Number of Contestants: #{@news_chic.contestant_count}")

    visit "/projects/#{@boardfit.id}"

    expect(page).to have_content("Number of Contestants: 1")
    expect(page).to have_content("Number of Contestants: #{@boardfit.contestant_count}")
  end

  it 'shows an average number of years experience between all contestants on the project' do
    visit "/projects/#{@boardfit.id}"

    expect(page).to have_content("Average Contestant Experience: 15")

    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("Average Contestant Experience: 12.5")
  end

  it 'has a form to add a contestant to a project that updates the show pages number of contestants, as well as the contestants index page' do
    visit "/projects/#{@boardfit.id}"

    expect(page).to have_button("Add Contestant To Project")

    fill_in(:contestant_id, with: @jay.id)
    click_button("Add Contestant To Project")

    expect(page).to have_current_path("/projects/#{@boardfit.id}")
    expect(page).to have_content("Number of Contestants: 2")
    expect(page).to have_content("Average Contestant Experience: 14")

    visit "/projects/#{@boardfit.id}"
    
    within "#contestant#{jay.id}" do
      expect(page).to have_content(jay.name)
      expect(page).to have_content(news_chic.name)
      expect(page).to have_content(boardfit.name)
    end
  end
end
