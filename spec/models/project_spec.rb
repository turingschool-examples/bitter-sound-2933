require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :material }
  end

  describe 'relationships' do
    it { should belong_to :challenge }
    it { should have_many :contestant_projects }
    it { should have_many(:contestants).through(:contestant_projects) }
  end

  describe 'behaviors' do
    it 'Can count the number of contestants' do
      recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
      news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
      jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
      gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)

      expect(news_chic.contestant_count).to eq(2)
    end

    it 'can return average years of experience of assigned contestants' do
      recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
      news_chic = recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
      jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
      gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
      oscar = Contestant.create(name: 'Oscar Grouch', age: 63, hometown: 'NYC', years_of_experience: 44)
      ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: oscar.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)

      expect(news_chic.average_exp).to eq(23)
    end
  end
end
