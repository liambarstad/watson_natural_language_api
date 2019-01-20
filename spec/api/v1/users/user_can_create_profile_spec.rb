require 'rails_helper'

RSpec.describe 'User can generate access token', type: :request do
  
  it 'with non-existing username' do
    post '/api/v1/get_token', params: { username: 'Liam' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body['token']).to_not be(nil)
    expect(body.keys.length).to_be(1)
    #decode jwt and test
  end

  it 'with existing username' do
    User.create!(username: 'Liam')
    post '/api/v1/get_token', params: { username: 'Liam' }
    
    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body['token']).to_not be(nil)
    expect(body.keys.length).to_be(1)
    #decode jwt and test
  end
end
