class CellsController < ApplicationController
  
  def edit
    @actions = Action.order(points: :desc)
    @cell_id = params[:id]
    @cell = Cell.find(params[:id])
    @round = Round.find(@cell.round_id)
    @card = @round.card
    @card_id = @card.id
    if (@cell.id == @round.redcornercell.id) 
      @boxer = Fighter.find(@card.match.redcorner)
    else # it's blue
      @boxer = Fighter.find(@card.match.bluecorner)
    end
    @boxer_full_name = @boxer.first_name + " " + @boxer.last_name
    @events_for_boxer_in_this_round = Event.where(:cell => @cell)
    @events_for_boxer_in_this_round.each do |event|
      action = Action.find(event.action.id)
      puts "An event for this action is: #{action.name}"
    end
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

  def destroy
    @event = Event.find(params[:event_id])
    @cell = @event.cell
    @round = @cell.round
    @card = @round.card
    @action_id = @event.action_id
    @action = Action.find(@action_id)
    puts "OBO BOOB O BO BO BO BO BO BOBOB O OBO BOOB O BO BO BO BO BO BOBOB O OBO BOOB O BO BO BO BO BO BOBOB O OBO BOOB O BO BO BO BO BO BOBOB O "
    puts "@action.name is #{@action.name}"
    puts "OBO BOOB O BO BO BO BO BO BOBOB O OBO BOOB O BO BO BO BO BO BOBOB O OBO BOOB O BO BO BO BO BO BOBOB O OBO BOOB O BO BO BO BO BO BOBOB O "
    if (@action.result_type == 'POSITIVEPOINTS')
      delete_both_boxers_previous_postive_points(@round, @cell)
    else 
      Event.destroy(@event)
      #TODO: Handle TKO and such
    end
    redirect_to edit_cell_path(@cell.id), :notice => "The action was successfully removed!"
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
