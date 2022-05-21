class ContestantProjectsController < ApplicationController

  def create
    ContestProject.create(contestant_id: params[:contestant_id], project_id: params[:project_id])
    redirect_to "/projects/#{params[:project_id]}"
  end
end
