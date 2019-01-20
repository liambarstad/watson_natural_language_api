class User < ApplicationRecord
  validates_presence_of :username
  has_one :access_token
end
