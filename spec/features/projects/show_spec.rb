require 'rails_helper' 

RSpec.describe 'projects show page', type: :feature do

    it 'displays the projects namd and material' do
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

        visit "/projects/#{news_chic.id}"
        
        expect(page).to have_content(news_chic.name)
        expect(page).to have_content(news_chic.material)
        expect(page).to_not have_content(boardfit.name)
        expect(page).to_not have_content(boardfit.material)

        visit "/projects/#{boardfit.id}"

        expect(page).to have_content(boardfit.name)
        expect(page).to have_content(boardfit.material)
        expect(page).to_not have_content(news_chic.name)
        expect(page).to_not have_content(news_chic.material)
    end

    it 'displays the them of the challenge that the project belongs to' do
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
        erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
        ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
        ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

        visit "/projects/#{news_chic.id}"
        
        expect(page).to have_content(recycled_material_challenge.theme)
    end

    it 'displays count of number of contestants on the project' do
        furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      
        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
        boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
        lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")


        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
        erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

        ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
        ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

        visit "/projects/#{news_chic.id}"
        expect(page).to have_content("Number of Contestants: 2")
        visit "/projects/#{upholstery_tux.id}"
        expect(page).to have_content("Number of Contestants: 1")
        visit "/projects/#{boardfit.id}"
        expect(page).to have_content("Number of Contestants: 2")
        visit "/projects/#{lit_fit.id}"
        expect(page).to have_content("Number of Contestants: 0")
    end

    it 'displays average years of experience of contestants on project' do
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
        boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
        lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 40, hometown: "NYC", years_of_experience: 12)
        kentaro = Contestant.create(name: "Kentaro Kameyama", age: 20, hometown: "Boston", years_of_experience: 8)
        erin = Contestant.create(name: "Erin Robertson", age: 32, hometown: "Denver", years_of_experience: 15)

        ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
        ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: boardfit.id)

        visit "/projects/#{news_chic.id}"
        expect(page).to have_content("Average Contestant Experiences: 12.5 years")
        visit "/projects/#{upholstery_tux.id}"
        expect(page).to have_content("Average Contestant Experiences: 10.0 years")
        visit "/projects/#{boardfit.id}"
        expect(page).to have_content("Average Contestant Experiences: 11.67 years")
    end

    it 'has a form to enter contestant id to add to project' do
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 40, hometown: "NYC", years_of_experience: 12)
        
        ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
       
        visit "/projects/#{news_chic.id}"
        expect(page).to have_content("Number of Contestants: 1")

        fill_in('project_id', with: gretchen.id)
        click_button('Add Contestant To Project')

        expect(current_path).to eq("/projects/#{news_chic.id}")
        expect(page).to have_content("Number of Contestants: 2")
    end
end