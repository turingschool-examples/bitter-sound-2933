class ContestantsController < ApplicationController
  def index
    @contestant = Contestant.all
  end
end
