require 'rails_helper'

RSpec.describe 'the contestant index page' do
  it "shows all the contestants and the list of projects names they've been on" do
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
    contestant_1 = Contestant.create!(name: "Kentaro Kameyama", age: 18, hometown: 'Chicago', years_of_experience: 4)
    contestant_2 = Contestant.create!(name: "Jay McCarroll", age: 21, hometown: 'Denver', years_of_experience: 2)

    challenge = Challenge.create!(theme: 'Apartment Furnishings', project_budget: 500)
    project_1 = challenge.projects.create!(name: 'Litfit', material: 'Lamp Shade')
    project_2 = challenge.projects.create!(name: 'Rug Tuxedo', material: 'Lamp Shade')
    project_3 = challenge.projects.create!(name: 'LeatherFeather', material: 'Lamp Shade')

    contestant_project_1 = ContestantProject.create!(contestant_id: contestant_1.id, project_id: project_1.id)
    contestant_project_2 = ContestantProject.create!(contestant_id: contestant_1.id, project_id: project_2.id)
    contestant_project_3 = ContestantProject.create!(contestant_id: contestant_2.id, project_id: project_3.id)

    visit "/contestants"


    within "#contestant-#{contestant_1.id}" do
      expect(page).to have_content(project_1.name)
      expect(page).to have_content(project_2.name)
      expect(page).to_not have_content(project_3.name)
    end

    within "#contestant-#{contestant_2.id}" do
      expect(page).to_not have_content(project_1.name)
      expect(page).to_not have_content(project_2.name)
      expect(page).to have_content(project_3.name)
    end
  end
end
