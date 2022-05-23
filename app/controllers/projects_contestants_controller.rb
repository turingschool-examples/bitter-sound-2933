class ProjectsContestantsController < ApplicationController

  def create
    ContestantProject.create(contestant_id: params[:contestant_id], project_id: params[:id])
    redirect_to "/projects/#{params[:id]}"
  end
end
