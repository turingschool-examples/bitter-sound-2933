class ContestantsController < ApplicationController

  def index
    # require "pry"; binding.pry
    @contestants = Contestant.all
  end

end
