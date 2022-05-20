class ProjectContestantsController < ApplicationController
    def new
       @project = Project.find(params[:id])
    end

    def create
        project = Project.find(params[:id])
        contestant = Contestant.find(params[:add_new])
        ContestantProject.create!(project: project, contestant: contestant)
        redirect_to "/projects/#{project.id}"
    end
    
end