class Tone < ApplicationRecord
  validates_uniqueness_of :emotion
  validates_presence_of :emotion

  has_many :feedbacks
end
