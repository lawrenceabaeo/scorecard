class Card < ActiveRecord::Base
  belongs_to :match
  belongs_to :user
  has_many :rounds
end
