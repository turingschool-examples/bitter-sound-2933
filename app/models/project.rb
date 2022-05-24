class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def project_theme
    self.challenge.theme
  end

  def num_contestants
    self.contestants.count
  end

  def avg_cont_age
    if self.contestants.empty?
      0
    else
      self.contestants.average(:years_of_experience).round(2)
    end
  end
end
