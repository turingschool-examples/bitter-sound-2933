class ContestantsController < ApplicationController

  def index
    @contestants = Contestant.all.distinct
  end
end
