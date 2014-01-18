class Cell < ActiveRecord::Base
  belongs_to :redcornercell_slots, class_name: "Rounds", foreign_key: "redcornercell_id"
  belongs_to :bluecornercell_slots, class_name: "Rounds", foreign_key: "bluecornercell_id"
  belongs_to :round

  has_many :events

  protected # ==========================================================
  def self.cell_points_total(cell)
    total_points = 0
    cell.events.each do |event|
      total_points += event.action.points
    end
    return total_points
  end

end
