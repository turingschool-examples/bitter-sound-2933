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
end
