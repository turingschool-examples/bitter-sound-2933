class ContestantProjectsController < ApplicationController
  def create
    con_pro = ContestantProject.new(contestant_projects_params)
    redirect_to "/projects/#{con_pro.project_id}"
  end

  private

  def contestant_projects_params
    params.permit(:contestant_id, :project_id)
  end
end
