class Contestant <ApplicationRecord
  validates_presence_of :name, :age, :hometown, :years_of_experience

  has_many :contestant_projects
  has_many :projects, through: :contestant_projects

  def all_projects
    project_names = []
    projects.each do |project|
      project_names << project.name
    end
    project_names
  end
end
