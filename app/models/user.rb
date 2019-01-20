class User < ApplicationRecord
  validates_presence_of :api_key
  has_one :access_token, dependent: :destroy

  def generate_access_token

  end
end
