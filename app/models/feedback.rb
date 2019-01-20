class Feedback < ApplicationRecord
  validates_presence_of :message
end
