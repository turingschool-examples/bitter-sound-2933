class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge

  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def challenge_theme
    challenge.theme
  end

  def number_of_contestants
    contestants.count
  end

  def contestants_average_experience
    contestants.average(:years_of_experience).to_f
  end
end
