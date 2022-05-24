class ProjectsController < ApplicationController

  def show
    @project = Project.find(params[:id])
    @num_cont = @project.contestant_count
    @yoe = @project.yoe
  end

end