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
    describe "#contestant_count" do
      it "counts number of contestants for a given project" do
            furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
            lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
            jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
            gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
            kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
            ContestantProject.create(contestant_id: jay.id, project_id: lit_fit.id)
            ContestantProject.create(contestant_id: gretchen.id, project_id: lit_fit.id)
            ContestantProject.create(contestant_id: kentaro.id, project_id: lit_fit.id)
            expect(lit_fit.contestant_count).to eq(3)
      end
    end
  end
  
end
