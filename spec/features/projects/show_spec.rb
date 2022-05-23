require 'rails_helper'

RSpec.describe 'the project show page' do
  it "shows the project and all it's attributes" do
    # As a visitor,
    # When I visit a project's show page ("/projects/:id"),
    # I see that project's name and material
    # And I also see the theme of the challenge that this project belongs to.
    # (e.g.    Litfit
    #   Material: Lamp Shade
    # Challenge Theme: Apartment Furnishings)
    challenge = Challenge.create!(theme: 'Apartment Furnishings', project_budget: 500)
    project = challenge.projects.create!(name: 'Litfit', material: 'Lamp Shade')
    # binding.pry

    # shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    # pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)


    visit "/projects/#{project.id}"
    # save_and_open_page
    #
    expect(page).to have_content(project.name)
    expect(page).to have_content(project.material)
    expect(page).to have_content(challenge.theme)
  end

  it 'see the count of the number of contestants on this page' do
    # User Story 3 of 3
    # As a visitor,
    # When I visit a project's show page
    # I see a count of the number of contestants on this project
    #
    # (e.g.    Litfit
    #     Material: Lamp Shade
    #   Challenge Theme: Apartment Furnishings
    #   Number of Contestants: 3 )

    contestant_1 = Contestant.create!(name: "Kentaro Kameyama", age: 18, hometown: 'Chicago', years_of_experience: 4)
    contestant_2 = Contestant.create!(name: "Jay McCarroll", age: 21, hometown: 'Denver', years_of_experience: 2)

    challenge = Challenge.create!(theme: 'Apartment Furnishings', project_budget: 500)
    project_1 = challenge.projects.create!(name: 'Litfit', material: 'Lamp Shade')

    contestant_project_1 = ContestantProject.create!(contestant_id: contestant_1.id, project_id: project_1.id)
    contestant_project_2 = ContestantProject.create!(contestant_id: contestant_2.id, project_id: project_1.id)

    visit "/projects/#{project_1.id}"
    # save_and_open_page

    expect(page).to have_content("Number of Contestants: 2")

    contestant_3 = Contestant.create!(name: "Jean", age: 21, hometown: 'Denver', years_of_experience: 2)
    contestant_project_3 = ContestantProject.create!(contestant_id: contestant_3.id, project_id: project_1.id)
    visit "/projects/#{project_1.id}"

    expect(page).to have_content("Number of Contestants: 3")
  end

  it 'give me the average years of experience of the contestants on the project' do
    # As a visitor,
    # When I visit a project's show page
    # I see the average years of experience for the contestants that worked on that project
    # (e.g.    Litfit
    #     Material: Lamp Shade
    #   Challenge Theme: Apartment Furnishings
    #   Number of Contestants: 3
    #   Average Contestant Experience: 10.25 years)
    contestant_1 = Contestant.create!(name: "Kentaro Kameyama", age: 18, hometown: 'Chicago', years_of_experience: 4)
    contestant_2 = Contestant.create!(name: "Jay McCarroll", age: 21, hometown: 'Denver', years_of_experience: 2)

    challenge = Challenge.create!(theme: 'Apartment Furnishings', project_budget: 500)
    project_1 = challenge.projects.create!(name: 'Litfit', material: 'Lamp Shade')

    contestant_project_1 = ContestantProject.create!(contestant_id: contestant_1.id, project_id: project_1.id)
    contestant_project_2 = ContestantProject.create!(contestant_id: contestant_2.id, project_id: project_1.id)

    visit "/projects/#{project_1.id}"
    # save_and_open_page

    expect(page).to have_content("Average Contestant Experience: 3 years")

    contestant_3 = Contestant.create!(name: "Jean", age: 21, hometown: 'Denver', years_of_experience: 21)
    contestant_project_3 = ContestantProject.create!(contestant_id: contestant_3.id, project_id: project_1.id)
    visit "/projects/#{project_1.id}"

    expect(page).to have_content("Average Contestant Experience: 9 years")
  end

  it 'can add a contestant to a project' do
    # User Story Extension 2 - Adding a contestant to a project
    #
    # As a visitor,
    # When I visit a project's show page
    # I see a form to add a contestant to this project
    # When I fill out a field with an existing contestants id
    # And hit "Add Contestant To Project"
    # I'm taken back to the project's show page
    # And I see that the number of contestants has increased by 1
    # And when I visit the contestants index page
    # I see that project listed under that contestant's name

    contestant_1 = Contestant.create!(name: "Kentaro Kameyama", age: 18, hometown: 'Chicago', years_of_experience: 4)
    contestant_2 = Contestant.create!(name: "Jay McCarroll", age: 21, hometown: 'Denver', years_of_experience: 2)
    contestant_3 = Contestant.create!(name: "Jean", age: 21, hometown: 'Denver', years_of_experience: 21)

    challenge = Challenge.create!(theme: 'Apartment Furnishings', project_budget: 500)
    project_1 = challenge.projects.create!(name: 'Litfit', material: 'Lamp Shade')
    # project_2 = challenge.projects.create!(name: 'Other Project', material: 'Lamp Shade')

    contestant_project_1 = ContestantProject.create!(contestant_id: contestant_1.id, project_id: project_1.id)
    contestant_project_2 = ContestantProject.create!(contestant_id: contestant_2.id, project_id: project_1.id)

    visit "/projects/#{project_1.id}"
    expect(page).to have_content("Number of Contestants: 2")

    # save_and_open_page

    fill_in 'Id', with: "#{contestant_3.id}"
    click_button 'Add Contestant To Project'

    expect(page).to have_content("Number of Contestants: 3")

    visit "/contestants"

    within "#contestant-#{contestant_3.id}" do
      expect(page).to have_content(project_1.name)
    end

  end
end
