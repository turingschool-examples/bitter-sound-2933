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
    save_and_open_page

    expect(page).to have_content("Number of Contestants: 2")

    contestant_3 = Contestant.create!(name: "Jean", age: 21, hometown: 'Denver', years_of_experience: 2)
    contestant_project_3 = ContestantProject.create!(contestant_id: contestant_3.id, project_id: project_1.id)
    visit "/projects/#{project_1.id}"

    expect(page).to have_content("Number of Contestants: 3")
  end
end
