class Match < ActiveRecord::Base
  belongs_to :fighter_a
  belongs_to :venue
end
