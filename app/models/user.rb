class User < ApplicationRecord
  validates_presence_of :api_key
  has_one :access_token, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  enum role: [:default, :admin]

  def generate_access_token
    token = JWTService.encode_token(id, api_key)
    self.access_token = AccessToken.new(token: token)
    save!
  end

end
