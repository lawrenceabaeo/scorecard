class Event < ActiveRecord::Base
  belongs_to :cell
  belongs_to :action
end
