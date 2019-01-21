module JWTService

  def self.encode_token(id, api_key)
    expiry = (Time.now + 60*60).to_i
    payload = { id: id, expiry: expiry }
    token = JWT.encode payload, api_key, 'HS256'
    AccessToken.new(token: token)
  end
  
end
