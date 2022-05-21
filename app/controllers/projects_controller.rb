class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    if params[:add_contestant_id]
      contestant = Contestant.find(params[:add_contestant_id])
      ContestantProject.create!(contestant: contestant, project: @project)
    end
  end

end
