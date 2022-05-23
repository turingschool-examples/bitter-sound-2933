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

  it 'can count the contestants' do
    contestant_1 = Contestant.create!(name: "Kentaro Kameyama", age: 18, hometown: 'Chicago', years_of_experience: 4)
    contestant_2 = Contestant.create!(name: "Jay McCarroll", age: 21, hometown: 'Denver', years_of_experience: 2)

    challenge = Challenge.create!(theme: 'Apartment Furnishings', project_budget: 500)
    project_1 = challenge.projects.create!(name: 'Litfit', material: 'Lamp Shade')

    contestant_project_1 = ContestantProject.create!(contestant_id: contestant_1.id, project_id: project_1.id)
    contestant_project_2 = ContestantProject.create!(contestant_id: contestant_2.id, project_id: project_1.id)

    expect(project_1.contestant_count).to eq(2)

    contestant_3 = Contestant.create!(name: "Jean", age: 21, hometown: 'Denver', years_of_experience: 2)
    contestant_project_3 = ContestantProject.create!(contestant_id: contestant_3.id, project_id: project_1.id)

    expect(project_1.contestant_count).to eq(3)
  end

  it 'can give me the average exp years' do
    contestant_1 = Contestant.create!(name: "Kentaro Kameyama", age: 18, hometown: 'Chicago', years_of_experience: 4)
    contestant_2 = Contestant.create!(name: "Jay McCarroll", age: 21, hometown: 'Denver', years_of_experience: 2)
    contestant_3 = Contestant.create!(name: "Jean", age: 21, hometown: 'Denver', years_of_experience: 21)
    
    challenge = Challenge.create!(theme: 'Apartment Furnishings', project_budget: 500)
    project_1 = challenge.projects.create!(name: 'Litfit', material: 'Lamp Shade')

    contestant_project_1 = ContestantProject.create!(contestant_id: contestant_1.id, project_id: project_1.id)
    contestant_project_2 = ContestantProject.create!(contestant_id: contestant_2.id, project_id: project_1.id)
    contestant_project_3 = ContestantProject.create!(contestant_id: contestant_3.id, project_id: project_1.id)

    expect(project_1.average_exp_years).to eq(9)
  end
end
