class ContestantsController < ApplicationController
  def index
    @contestants = Contestant.all
    #@projects = @contestants.projects
    #can't do line 4 bc line 3 is array, and can't call projects on an array
  end
end
