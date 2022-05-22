require 'rails_helper'


RSpec.describe Project, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe "instance methods" do
    it 'counts numbers of contestants on a project' do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

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
      ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
      ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
      ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

      expect(news_chic.count_contestants).to eq(2)
      expect(upholstery_tux.count_contestants).to eq(2)
      expect(boardfit.count_contestants).to eq(2)
      expect(lit_fit.count_contestants).to eq(0)
    end

    it 'returns the ages of contestants on project' do
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

      expect(news_chic.contestants_years_of_experiences).to eq([13, 12])
      expect(upholstery_tux.contestants_years_of_experiences).to eq([12, 8])
      expect(boardfit.contestants_years_of_experiences).to eq([12, 8, 15])
    end
  end
end
