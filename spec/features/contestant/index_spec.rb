require 'rails_helper'

RSpec.describe 'Contestant Index Page' do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)


    @project_1 = ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    @project_2 = ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)

  end
  it "can visit the contestant index page and see all contestants with there projects" do
    visit '/contestants'

    expect(current_path).to eq('/contestants')

    expect(page).to have_content("Jay McCarroll")
    expect(page).to have_content("Gretchen Jones")
    expect(page).to have_content("News Chic")

  end
end
