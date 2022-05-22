require 'rails_helper'

RSpec.describe 'contestants index page', type: :feature do

        it 'displays list of all contestant names' do
            jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
            gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
            kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
            erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

            visit '/contestants'

            expect(page).to have_content(jay.name)
            expect(page).to have_content(gretchen.name)
            expect(page).to have_content(kentaro.name)
            expect(page).to have_content(erin.name)
        end
end