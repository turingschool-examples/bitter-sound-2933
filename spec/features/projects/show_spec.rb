require 'spec_helper'

RSpec.describe Project, type: :feature do
  describe 'project show page' do
    it 'can see project info' do
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
      lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

      visit("/projects/#{lit_fit.id}")

      expect(page).to have_content("Litfit")
      expect(page).to have_content("Lamp")
      expect(page).to have_content("Apartment Furnishings")
    end
  end
end
