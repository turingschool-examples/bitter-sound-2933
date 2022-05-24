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

  def avg_experience
    # binding.pry
    if contestants.count > 0
      (contestants.sum(:years_of_experience).to_f / contestants.count)
    else
      0
    end
  end
end
