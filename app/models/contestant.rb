class Contestant <ApplicationRecord
  validates_presence_of :name, :age, :hometown, :years_of_experience
  has_many :contestant_projects
  has_many :projects, through: :contestant_projects

  def project_list
    proj_list = []
    self.projects.each do |project|
      proj_list << project.name
    end
    proj_list.join(', ')
  end
end
