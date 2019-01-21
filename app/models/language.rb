class Language < ApplicationRecord
  validates_presence_of :abbr, :name
  validates_uniqueness_of :abbr, :name
  has_many :feedbacks
end
