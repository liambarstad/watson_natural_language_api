module JWTService

  def self.encode_token(id, api_key)
    expiry = (Time.now + 60*60).to_i
    payload = { id: id, expiry: expiry }
    JWT.encode payload, api_key, 'HS256'
  end
  
  def self.decode(token, api_key)
    begin
      decoded_content = JWT.decode token, api_key, true, { algorithm: 'HS256' }
      decoded_content[0]
    rescue JWT::DecodeError
      return {}
    end
  end

end
