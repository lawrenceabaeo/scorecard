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

  def self.any_fight_stoppage_events?(card, blue_or_red_corner)
    if Card.first_fight_stoppage_event(card, blue_or_red_corner) > 0
      return true
    else
      return false
    end
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
  
end
