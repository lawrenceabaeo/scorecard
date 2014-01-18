class Card < ActiveRecord::Base
  belongs_to :match
  belongs_to :user
  has_many :rounds

  protected # ==========================================================
  def self.corner_results(card, corner)
    # count all events for a fighter on a card 
    
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

end
