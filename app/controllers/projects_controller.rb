class ProjectsController < ApplicationController

  # def index
  #   @projects = Project.all
  # end

  def show
    @project = Project.find(params[:id])
  end
  #
  def create
    project = Project.last
    @contestant = Contestant.find(params[:id])
    @contestant_project_1 = ContestantProject.create!(contestant_id: @contestant.id, project_id: project.id)
    # binding.pry
    redirect_to "/projects/#{project.id}"
  end

  private

    def project_params
      params.permit(:name, :material, :challenge_id)
    end

end
