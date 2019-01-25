class Search < ApplicationRecord
  validates_presence_of :resource
  belongs_to :language, required: false
  belongs_to :tone, required: false
end
