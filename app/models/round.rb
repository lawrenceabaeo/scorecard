class Round < ActiveRecord::Base
  belongs_to :card
  belongs_to :redcornercell, class_name: "Cell", foreign_key: "redcornercell_id"
  belongs_to :bluecornercell, class_name: "Cell", foreign_key: "bluecornercell_id"
  has_many :cells
  
  validates :round_number, presence: true
end
