require 'rails_helper'

RSpec.describe 'Project show page' do
  it "can display a project's name, material, and theme" do
    recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    furniture_challenge = Challenge.create(theme: 'Apartment Furnishings', project_budget: 1000)

    news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    boardfit = recycled_material_challenge.projects.create(name: 'Boardfit', material: 'Cardboard Boxes')

    upholstery_tux = furniture_challenge.projects.create(name: 'Upholstery Tuxedo', material: 'Couch')
    lit_fit = furniture_challenge.projects.create(name: 'Litfit', material: 'Lamp')

    visit "/projects/#{news_chic.id}"

    expect(page).to have_content(news_chic.name)

    expect(page).to have_content(news_chic.material)

    expect(page).to have_content(news_chic.challenge.theme)
  end

  it 'can display count of contestants on this project' do
    recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    furniture_challenge = Challenge.create(theme: 'Apartment Furnishings', project_budget: 1000)

    news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    boardfit = recycled_material_challenge.projects.create(name: 'Boardfit', material: 'Cardboard Boxes')

    upholstery_tux = furniture_challenge.projects.create(name: 'Upholstery Tuxedo', material: 'Couch')
    lit_fit = furniture_challenge.projects.create(name: 'Litfit', material: 'Lamp')

    jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
    gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
    kentaro = Contestant.create(name: 'Kentaro Kameyama', age: 30, hometown: 'Boston', years_of_experience: 8)
    erin = Contestant.create(name: 'Erin Robertson', age: 44, hometown: 'Denver', years_of_experience: 15)

    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
    ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
    ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

    visit "/projects/#{news_chic.id}"

    within("div##{news_chic.id}") do
      expect(page).to have_content('Number of Contestants:')
      expect(page).to have_content('2')
    end

    visit "/projects/#{upholstery_tux.id}"

    within("div##{upholstery_tux.id}") do
      expect(page).to have_content('Number of Contestants:')
      expect(page).to have_content('2')
    end

    visit "/projects/#{boardfit.id}"

    within("div##{boardfit.id}") do
      expect(page).to have_content('Number of Contestants:')
      expect(page).to have_content('2')
    end
  end
  it 'can display the average years of experience for participating contestants' do
    recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
    gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
    oscar = Contestant.create(name: 'Oscar Grouch', age: 63, hometown: 'NYC', years_of_experience: 44)
    ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: oscar.id, project_id: news_chic.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)

    visit "/projects/#{news_chic.id}"
    within('div#contestantExperience') do
      expect(page).to have_content('Average Contestant Experience:')
      expect(page).to have_content('23')
    end
  end
end
