require 'rails_helper'

RSpec.describe 'new contestant' do 
    describe 'extension 2' do 
        it 'can add a contestant to the page' do 
            recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
            furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

            boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
            upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
            lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

            jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
            gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
            kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
            erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


            ContestantProject.create(contestant_id: jay.id, project_id: lit_fit.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: lit_fit.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
            ContestantProject.create(contestant_id: kentaro.id, project_id: lit_fit.id)
            ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
            ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

            visit "/projects/#{boardfit.id}"
            expect(page).to have_content("Add Contestant Form")
    
            fill_in(:name, with: 'Harry')
            fill_in(:age, with: 42)
            fill_in(:hometown, with: 'Pheonix')
            fill_in(:years_of_experience, with: 32)

            click_button('Submit')
            
            expect(current_path).to eq("/projects/#{boardfit.id}")
            expect(page).to have_content('Harry')
            expect(page).to have_content("Number of Contestants: 3")

            visit '/contestants'

            within "##{harry.id}" do 
                expect(page).to have_content(boardfit.name)
            end
        end
    end
end