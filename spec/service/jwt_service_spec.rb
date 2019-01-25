require 'rails_helper'

RSpec.describe 'JWT Service' do

  describe 'encode/decode' do
    let!(:encoded_token) { JWTService.encode_token(1, 'f') }

    it 'with valid token' do
      decoded_token = JWTService.decode(encoded_token, 'f')

      expect(decoded_token['id']).to eq(1)
      expect(decoded_token['expiry']).to be > Time.now.to_i
    end

    it 'decode with no token' do
      decoded_token = JWTService.decode(nil, 'f')

      expect(decoded_token).to eq({})
    end

    it 'with no api key' do
      decoded_token = JWTService.decode(encoded_token, nil)

      expect(decoded_token).to eq({})
    end
  end

end
