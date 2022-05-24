class ContestantsController < ApplicationController

  def index
    @contestants = Contestant.all
  end

  def new
  end

  def create
    contestants = Contestant.create(contestant_params)
    redirect_to "/projects/#{@projects.id}"
  end

  private
    def contestant_params
      params.permit(:name, :age, :hometown, :years_of_experience)
    end
end
