class CellsController < ApplicationController
  def edit
    @actions = Action.order(points: :desc)
  end
end
