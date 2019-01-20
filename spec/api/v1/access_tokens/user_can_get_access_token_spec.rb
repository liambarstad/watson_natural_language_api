require 'rails_helper'

RSpec.describe 'User can get access token', type: :request do
  
  it 'with existing username' do
    user = User.create!(api_key: 'somestuff')
    post '/api/v1/access_tokens', params: { api_key: user.api_key  }
    
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body['token']).to_not be(nil)
    expect(body.keys.length).to be(1)
    #decode jwt and test
  end

  it 'with non-existing username' do
    post '/api/v1/access_tokens', params: { api_key: 'nada' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(400)
    expect(body['token']).to be(nil)
    expect(body['error']).to eq('API Key Invalid')
    expect(body.keys.length).to be(1)
  end

end
