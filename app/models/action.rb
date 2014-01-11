class Action < ActiveRecord::Base
  has_many :rounds

  validates :name, presence: true
  validates :points, presence: true
end
