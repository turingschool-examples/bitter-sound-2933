class Project < ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def contestant_count
    contestants.count
  end

  def average_exp
    total = []
    contestants.each do |contestant|
      total << contestant.years_of_experience
    end
    total.sum / contestants.count
  end
end
