class Contestant <ApplicationRecord
  validates_presence_of :name, :age, :hometown, :years_of_experience
  has_many :contestant_projects
  has_many :projects, through: :contestant_projects

  def list_projects
    projects.pluck(:name)
    # binding.pry
    # project_ids = ContestantProject.where("contestant_id = #{id}").pluck(:project_id)
    # binding.pry
    # Project.where(id: project_ids).order(id).pluck(:name)
  end
end
