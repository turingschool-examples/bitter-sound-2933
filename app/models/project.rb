class Project < ApplicationRecord
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  validates_presence_of :name, :material

  def count_contestants
    self.contestants.count
  end

  def ave_years_of_experience
    self.contestants.average(:years_of_experience)
  end
end
