class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @challenge = @project.challenge
    #vcould also do in view as project.challenge.theme
  end
end
