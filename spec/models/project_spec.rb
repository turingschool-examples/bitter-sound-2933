require 'rails_helper'


RSpec.describe Project, type: :model do
  before do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
  end

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
    it "returns the challenge theme for an individual project" do
      expect(@lit_fit.project_theme).to eq("Apartment Furnishings")
      expect(@boardfit.project_theme).to eq("Recycled Material")

    end
  end
end
