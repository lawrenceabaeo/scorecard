class Action < ActiveRecord::Base
  has_many :events
  
  validates :name, presence: true
  validates :points, presence: true
end
