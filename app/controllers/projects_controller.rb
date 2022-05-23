class ProjectsController < ApplicationController
  def show
    @projects = Project.find(params[:id])
  end
end
