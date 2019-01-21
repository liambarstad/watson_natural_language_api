class User < ApplicationRecord
  validates_presence_of :api_key
  has_one :access_token, dependent: :destroy
  has_many :feedbacks

  def generate_access_token
    self.access_token = JWTService.encode_token(id, api_key)
    save!
  end

end
