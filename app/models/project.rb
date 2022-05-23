class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def theme
    challenge.theme
  end

  def contestant_count
    contestants.count
  end

  def average_experience
    contestants.average(:years_of_experience)
  end
end
