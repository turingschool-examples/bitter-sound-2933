class ProjectsController < ApplicationController
    def show
        @project = Project.find(params[:id])
        # binding.pry
    end
end