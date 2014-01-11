class Match < ActiveRecord::Base
  belongs_to :fighter_a
  belongs_to :venue
  belongs_to :user

  validates :fighter_a, presence: true
  validates :total_rounds, presence: true
  # validates :fighter_b, presence: true

end
