class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def contestant_count
    contestants.count
  end

  def average_exp_years
    total_years = []
    contestants.each do |contestant|
      total_years << contestant.years_of_experience
    end

    if total_years.count == 0
      return 0
    else
      return total_years.sum / total_years.count
    end
    
  end
end
