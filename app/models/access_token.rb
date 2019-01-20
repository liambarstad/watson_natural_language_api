class AccessToken < ApplicationRecord
  validates_presence_of :token
  validates_uniqueness_of :token
end
