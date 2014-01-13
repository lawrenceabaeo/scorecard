class Cell < ActiveRecord::Base
  belongs_to :redcornercell_slots, class_name: "Rounds", foreign_key: "redcornercell_id"
  belongs_to :bluecornercell_slots, class_name: "Rounds", foreign_key: "bluecornercell_id"
  belongs_to :round

  has_many :events
end
