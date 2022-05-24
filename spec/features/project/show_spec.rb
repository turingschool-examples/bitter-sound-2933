require 'rails_helper'

RSpec.describe "the project show page" do
  it "displays a projects name and material as well as its associated challenge" do
    visit "/projects/#{boardfit.id}"

    expect(page).to have_content("Boardfit")
    expect(page).to have_content("Cardboard Boxes")
    expect(page).to have_content("Recycled Material")
  end
end
