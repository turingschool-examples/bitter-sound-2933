class Contestant <ApplicationRecord
  has_many :contestants
  validates_presence_of :name, :age, :hometown, :years_of_experience
end
