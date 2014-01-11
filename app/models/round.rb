class Round < ActiveRecord::Base
  belongs_to :card
  belongs_to :fighter
  belongs_to :action

  validates :round_number, presence: true
end
