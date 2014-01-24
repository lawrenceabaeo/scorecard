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
  end
  
  def update
    @action = Action.find(params[:action_id])
    @cell = Cell.find(params[:id])
    @round = Round.find(@cell.round_id)
    @card_id = @round.card_id
    card = Card.find(@card_id)
    @rounds_with_stoppage = Card.rounds_with_stoppage_events(card, "red") # we're assuming both boxers are scored correctly, so just automatically rely on red

    if @rounds_with_stoppage.empty? != true
      round_number_with_first_stoppage = @rounds_with_stoppage[0]
      round_object_with_first_stoppage = Round.where(:round_number => round_number_with_first_stoppage, :card => card).first
      red_cell_with_stoppage = round_object_with_first_stoppage.redcornercell_id
      current_round = @round.round_number
      if current_round <= round_number_with_first_stoppage
        if (@action.points == 0) # they want to apply another stoppage action, even though one already exists in a later round
          redirect_to edit_cell_path(red_cell_with_stoppage), :alert => "A fight-stoppage event already exists! Remove this event if you want to apply a fight stoppage somewhere else in the card!"
          return
        else # they want to apply win/loss/tie/deduction BEFORE the stoppage, which is fine
          apply_event(@round, @cell, @action)
        end
      else # they want to apply ANYTHING after a stoppage, so prevent them
        redirect_to edit_cell_path(red_cell_with_stoppage), :alert => "You already stopped the fight! Remove this fight-stoppage event if you want to apply actions to later rounds."
        return
      end 
    else # no stoppages occurred, just apply actions as usual
      apply_event(@round, @cell, @action)
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
    if ( (@action.result_type == 'POSITIVEPOINTS') || (@action.points == 0) )
      delete_both_boxers_previous_postive_points_or_stoppage_events(@round)
    else 
      Event.destroy(@event) # the only kind of events that remain are point deductions
    end
    redirect_to edit_cell_path(@cell.id), :notice => "The action was successfully removed!"
  end


  private # ========================================================================================

  def apply_event(round, cell, action)
    if (action.result_type == 'POSITIVEPOINTS' || action.points == 0)
      delete_both_boxers_previous_postive_points_or_stoppage_events(round)
      update_both_boxers(round, cell, action)
    else # the only thing left is negative points, so go ahead and create
      Event.create(:action => action, :cell => cell)
    end
  end

  def delete_both_boxers_previous_postive_points_or_stoppage_events(round)
    both_boxers_cells = [round.redcornercell, round.bluecornercell]
    both_boxers_cells.each do |cell|
      events = Event.where(:cell => cell)
      events.each do |event|
        if (event.action.result_type == 'POSITIVEPOINTS' || event.action.points == 0)
          Event.destroy(event)
        else
          # leave whatever's left alone, in this case, only negative points will remain
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
    
    elsif original_action.action_code == "Tie"
      related_action = Action.find_by_action_code("Tie")
    
    elsif original_action.action_code == "WinsByDQ"
      related_action = Action.find_by_action_code("LosesByDQ")
    
    elsif original_action.action_code == "LosesByDQ"
      related_action = Action.find_by_action_code("WinsByDQ")
    
    elsif original_action.action_code == "WinsByKO"
      related_action = Action.find_by_action_code("LosesByKO")
    
    elsif original_action.action_code == "LosesByKO"
      related_action = Action.find_by_action_code("WinsByKO")
    
    elsif original_action.action_code == "WinsByTKO"
      related_action = Action.find_by_action_code("LosesByTKO")
    
    elsif original_action.action_code == "LosesByTKO"
      related_action = Action.find_by_action_code("WinsByTKO")
    
    else original_action.action_code == "NC"
      related_action = Action.find_by_action_code("NC")      
    
    end
    Event.create(:action => related_action, :cell => boxer_cell)
  end

end