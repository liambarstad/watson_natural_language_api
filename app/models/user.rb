class User < ApplicationRecord
  validates_presence_of :username

  def token

  end

end
