class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge

  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def experience_average
    self.contestants.average(:years_of_experience).to_f
  end
end
