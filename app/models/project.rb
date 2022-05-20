class Project < ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def num_contestants
    contestants.count
  end

  def challenge_theme
    challenge.theme
  end

  def average_contestant_experience
    (contestants.pluck(:years_of_experience).sum.to_f / num_contestants).round(2)
  end
end
