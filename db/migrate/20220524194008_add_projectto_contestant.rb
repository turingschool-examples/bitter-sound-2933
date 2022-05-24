class AddProjecttoContestant < ActiveRecord::Migration[5.2]
  def change
    add_reference :contestants, :project, foreign_key: true
    add_reference :projects, :contestants, foreign_key: true
  end
end
