class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @project_theme = @project.challenge_theme
  end
end
