class Fighter < ActiveRecord::Base
  belongs_to :user
  has_many :rounds
  has_many :redcorner_matches, class_name: "Match", foreign_key: "redcorner_id"
  has_many :bluecorner_matches, class_name: "Match", foreign_key: "bluecorner_id"
end
