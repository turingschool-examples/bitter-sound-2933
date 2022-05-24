class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @library = Project.find(params[:id])
  end
end
