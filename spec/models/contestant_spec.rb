require 'rails_helper'

RSpec.describe Contestant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :hometown }
    it { should validate_presence_of :years_of_experience }
  end

  describe 'relationships' do
    it { should have_many :contestant_projects }
    it { should have_many(:projects).through(:contestant_projects) }
  end

  describe 'methods' do
    it 'can give a string of all projects name as string for a contestant' do
      recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
      news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
      boardfit = recycled_material_challenge.projects.create(name: 'Boardfit', material: 'Cardboard Boxes')
      jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
      ContestantProject.create(contestant_id: jay.id, project_id: boardfit.id)
      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      expect(jay.project_names).to eq('News Chic, Boardfit')
    end
  end
end
