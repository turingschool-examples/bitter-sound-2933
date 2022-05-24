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

  describe 'instance methods' do
    before(:each) do
      recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      @news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      @boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      @upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

      jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
      erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


      ContestantProject.create(contestant_id: jay.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: @upholstery_tux.id)
      ContestantProject.create(contestant_id: kentaro.id, project_id: @upholstery_tux.id)
      ContestantProject.create(contestant_id: kentaro.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: erin.id, project_id: @boardfit.id)
    end

    describe 'contestant_count' do
      it 'can return the number of contestants who worked on a project' do

        expect(@upholstery_tux.contestant_count).to eq(2)
        expect(@news_chic.contestant_count).to eq(3)
        expect(@boardfit.contestant_count).to eq(1)
      end
    end
    describe 'avg_year_exp' do
      it 'can return the average of contestants years of experience on a project' do

        expect(@upholstery_tux.avg_year_exp).to eq(10.00)
        expect(@news_chic.avg_year_exp).to eq(11.00)
        expect(@boardfit.avg_year_exp).to eq(15.00)
      end
    end
  end
end
