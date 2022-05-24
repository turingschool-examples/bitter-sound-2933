class Project < ApplicationRecord
  # binding.pry
  validates_presence_of :name
  validates_presence_of :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def number_of_contestants
    contestants.count
  end
end
