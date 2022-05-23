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


end
