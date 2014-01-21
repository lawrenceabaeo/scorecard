class CellsController < ApplicationController
  
  def edit
    @actions = Action.order(points: :desc)
    @cell_id = params[:id]
  end
  
  def update
    @cell = Cell.find(params[:id])
    @round = Round.find(@cell.round_id)
    @card_id = @round.card_id
    @action = Action.find(params[:action_id])
    if (@action.result_type == 'POSITIVEPOINTS')
      delete_both_boxers_previous_postive_points(@round, @cell)
      update_both_boxers(@round, @cell, @action)
    else 
      #TODO: Handle TKO and such
      Event.create(:action => @action, :cell => @cell)
    end
    redirect_to card_path(@card_id), :notice => "Your update was successful!"
  end

  private # ========================================================================================

  def delete_both_boxers_previous_postive_points(round, cell)
    both_boxers_cells = [round.redcornercell, round.bluecornercell]
    both_boxers_cells.each do |cell|
      events = Event.where(:cell => cell)
      events.each do |event|
        if (event.action.result_type == 'POSITIVEPOINTS')
          Event.destroy(event)
        end
      end
    end
  end

  def update_both_boxers(round, cell, action)
    Event.create(:action => @action, :cell => cell)
    if (cell.id == round.redcornercell.id)
      apply_related_action_to_this_boxer(action, round.bluecornercell)
    else # it's blue
      apply_related_action_to_this_boxer(action, round.redcornercell)
    end
  end

  def apply_related_action_to_this_boxer(original_action, boxer_cell)
    if original_action.action_code == "WinsRound"
      related_action = Action.find_by_action_code("LosesRound")
    elsif original_action.action_code == "LosesRound"
      related_action = Action.find_by_action_code("WinsRound")
    else # assume tie, as currenty that's the only remaining option
      related_action = Action.find_by_action_code("Tie")
    end
    Event.create(:action => related_action, :cell => boxer_cell)
  end
end
