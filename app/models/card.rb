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

end
