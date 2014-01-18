class CellsController < ApplicationController
  
  def edit
    @actions = Action.order(points: :desc)
    @cell_id = params[:id]
  end
  
  def update
    @cell_object = Cell.find(params[:id])
    @round_object = Round.find(@cell_object.round_id)
    @card_id = @round_object.card_id
    @action_object = Action.find(params[:action_id])
    Event.create(:action => @action_object, :cell => @cell_object)
    redirect_to card_path(@card_id), :notice => "You did something to this card!"
  end

private # ========================================================================================


end
