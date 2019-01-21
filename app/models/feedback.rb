class Feedback < ApplicationRecord
  validates_presence_of :message
  belongs_to :user, required: true
end
