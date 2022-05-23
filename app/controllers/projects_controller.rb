class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @challenge = Challenge.find(project_params[:challenge_id])
    project = Project.new(project_params)
  end

  private

    def project_params
      params.permit(:name, :material, :challenge_id)
    end

end
