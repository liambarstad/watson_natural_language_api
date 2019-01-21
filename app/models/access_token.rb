class AccessToken < ApplicationRecord
  validates_presence_of :token
  validates_uniqueness_of :token
  belongs_to :user

  def decode(api_key)
    JWTService.decode(token, api_key)
  end

end
