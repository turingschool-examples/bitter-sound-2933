class ProjectsController < ApplicationController

  def show
    @project = Project.find(params[:id])
    @number_of_contestants = @project.number_of_contestants
  end
end
