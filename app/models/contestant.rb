class Contestant <ApplicationRecord
  validates_presence_of :name, :age, :hometown, :years_of_experience

  has_many :contestant_projects
  has_many :projects, through: :contestant_projects

  def all_projects(id)
    contestant = Contestant.find(id)
    contestant.projects.select(:name)
  end
end
