require 'rails_helper'

RSpec.describe 'User can add feedback', type: :request do
  
  before :each do
    create(:language, abbr: 'en', name: 'English')
  end

  it 'with valid credentials' do
    token = get_token
    api_key = get_api_key(token)
    post '/api/v1/feedbacks', params: { api_key: api_key, token: token, message: 'This is a test' }
    access_token = AccessToken.find_by(token: token)

    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body['message']).to eq('This is a test')
    expect(Feedback.all.count).to eq(1)
    expect(access_token.user.feedbacks.count).to eq(1)
    expect(Feedback.first.message).to eq('This is a test')
  end

  it 'with invalid token' do
    api_key = get_api_key
    post '/api/v1/feedbacks', params: { api_key: api_key, token: 'random', message: 'This is a test' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(Feedback.all.count).to eq(0)
    expect(body.keys.length).to eq(1)
  end

  it 'with invalid api key' do
    token = get_token
    post '/api/v1/feedbacks', params: { api_key: 'nada', token: token, message: 'This is a test' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(Feedback.all.count).to eq(0)
    expect(body.keys.length).to eq(1)
  end

  it 'with no token' do
    post '/api/v1/feedbacks', params: { message: 'This is a test' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(Feedback.all.count).to eq(0)
    expect(body.keys.length).to eq(1)
  end

end
