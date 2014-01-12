class Match < ActiveRecord::Base
  belongs_to :venue
  belongs_to :user
  has_many :cards

  belongs_to :redcorner, class_name: "Fighter", foreign_key: "redcorner_id"
  belongs_to :bluecorner, class_name: "Fighter", foreign_key: "bluecorner_id"

  validates :total_rounds, presence: true

end
