class Card < ActiveRecord::Base
  belongs_to :match
  belongs_to :user
  has_many :rounds

  protected # ==========================================================
  def self.current_score(card, corner)
    # count points for all events for a fighter on a card 
    running_total = 0
    card.rounds.each do |round|
      if corner == "red"
        running_total += Cell.cell_points_total(round.redcornercell)
      else
        running_total += Cell.cell_points_total(round.bluecornercell)
      end
    end
    return running_total
  end

  def self.final_score(card, blue_or_red_corner)
    # Check if user was awarded points in last round
    total_rounds = card.match.total_rounds
    last_round  = card.rounds.find_by_round_number(total_rounds)
    if blue_or_red_corner == "red"
      last_cell = last_round.redcornercell
    else 
      last_cell = last_round.bluecornercell
    end
    events_for_last_cell = Event.where(:cell_id => last_cell)
    if Card.round_for_boxer_has_positive_points_awarded?(events_for_last_cell)
      if (some_rounds_are_missing_positive_points?(card, blue_or_red_corner) == false)
         return Card.current_score(card, blue_or_red_corner)
       end
    end
    # Don't even bother if the last round was not scored yet
  end

  def self.some_rounds_are_missing_positive_points?(card, blue_or_red_corner)
    missing_points = false
    card.rounds.each do |round|
      if blue_or_red_corner == "red"
        check_these_events = round.redcornercell.events
      else 
        check_these_events = round.bluecornercell.events
      end
      if (Card.round_for_boxer_has_positive_points_awarded?(check_these_events) == false)
        missing_points = true
        return
      end
    end
    return missing_points
  end

  def self.round_for_boxer_has_positive_points_awarded?(events)
    events.each do |e|
      if (e.action.points > 0)
        return true
      end
    end
    return false
  end

  def self.rounds_with_stoppage_events(card, blue_or_red_corner)
    these_rounds = Array.new
    rounds = card.rounds.order("round_number ASC")
    rounds.each do |round|
      if blue_or_red_corner == "red"
        cell = round.redcornercell
      else 
        cell = round.bluecornercell
      end
      if (Card.any_stoppage_events_for_cell?(cell))
        these_rounds << round.round_number
      end
    end
    return these_rounds
  end

  def self.any_stoppage_events_for_cell?(cell)
      events_for_cell = cell.events
      events_for_cell.each do |event|
        if (event.action.points == 0) # 0 is the 'points' we use to indicate fight stoppage
          # puts "Yes, there was a stoppage event for this cell"
          return true
        end
      end
      # puts "NO, there was NO stoppage event cell"
      return false
  end

  def self.check_first_or_last_stoppage_event(card, blue_or_red_corner, first_or_last)
    if order == "last"
      this_order = "round_number DESC"
    else
      this_order = "round_number ASC"
    end
    
    round_with_stoppage = 0
    rounds = card.rounds.order(this_order)
    rounds.each do |round|
      if blue_or_red_corner == "red"
        check_these_events = round.redcornercell.events
      else 
        check_these_events = round.bluecornercell.events
      end

      check_these_events.each do |event|
        if (event.action.points == 0) # 0 is the 'points' we use to indicate fight stoppage
          first_round_with_stoppage = round.round_number
          return first_round_with_stoppage
        end
      end
    end
    return round_with_stoppage
  end

  def self.last_stoppage_event_in_cell(cell)
    events = Event.where(:cell_id => cell).order("created_at ASC")
    stoppage_events = Array.new
    events.each do |event|
      action = Action.find(event.action_id)
      if action.points == 0
        stoppage_events << event
      end
    end
    return stoppage_events.last
  end
  
  def self.display_card_result_statement(card, round_number_where_stoppage_occurred)
    result_statement = ""

    round_object = Round.where(:card_id => card.id, :round_number => round_number_where_stoppage_occurred).first
    red_stoppage_event = Card.last_stoppage_event_in_cell(round_object.redcornercell)
    red_stoppage_action = Action.find(red_stoppage_event.action_id)
    if red_stoppage_action.result_type == "WIN"
      redboxer = Fighter.find(card.match.redcorner)
      redboxer_full_name = redboxer.first_name + " " + redboxer.last_name
      result_statement = "#{redboxer_full_name} #{red_stoppage_action.name} in Round #{round_number_where_stoppage_occurred}"
    elsif red_stoppage_action.result_type == "NC"
      result_statement = "NO CONTEST declared in Round #{round_number_where_stoppage_occurred}"
    else # it means that blue won so...
      boxer = Fighter.find(card.match.bluecorner)
      boxer_full_name = boxer.first_name + " " + boxer.last_name
      blue_stoppage_event = Card.last_stoppage_event_in_cell(round_object.bluecornercell)
      blue_stoppage_action = Action.find(blue_stoppage_event.action_id)
      result_statement = "#{boxer_full_name} #{blue_stoppage_action.name} in Round #{round_number_where_stoppage_occurred}"   
    end
    return result_statement
  end

  def self.all_rounds_scored_from_both_fighters?(card)
    missing_red = Card.some_rounds_are_missing_positive_points?(card, "red")
    missing_blue = Card.some_rounds_are_missing_positive_points?(card, "blue")
    if ( (missing_red == false) && (missing_blue == false) )
      return true
    else
      return false
    end
  end

  def self.display_card_result_statement_due_to_scoring(card)
    result_statement = ""
    red_final_score = Card.final_score(card, "red")
    blue_final_score = Card.final_score(card, "blue")
    if red_final_score > blue_final_score
      boxer = Fighter.find(card.match.redcorner)
      boxer_full_name = boxer.first_name + " " + boxer.last_name
      result_statement = "#{boxer_full_name} WINS on your scorecard, #{red_final_score} to #{blue_final_score}"
    elsif blue_final_score > red_final_score 
      boxer = Fighter.find(card.match.bluecorner)
      boxer_full_name = boxer.first_name + " " + boxer.last_name
      result_statement = "#{boxer_full_name} WINS on your scorecard, #{blue_final_score} to #{red_final_score}"
    elsif red_final_score == blue_final_score
      result_statement = "The match ends in a TIE."
    end
    return result_statement
  end

end
