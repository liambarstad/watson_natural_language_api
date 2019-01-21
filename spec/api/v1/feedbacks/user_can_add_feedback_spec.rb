require 'rails_helper'

RSpec.describe 'User can add feedback', type: :request do
  
  it 'with valid credentials' do
    token = get_token
    post '/api/v1/feedbacks', params: { token: token, message: 'This is a test' }
    access_token = AccessToken.find_by(token: token)

    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body['message']).to eq('This is a test')
    expect(Feedback.all.count).to eq(1)
    expect(access_token.user.feedbacks.count).to eq(1)
    expect(Feedback.first.message).to eq('This is a test')
  end

  it 'with invalid key' do
    post '/api/v1/feedbacks', params: { token: 'random', message: 'This is a test' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(Feedback.all.count).to eq(0)
    expect(body.keys.length).to eq(1)
  end

  it 'with no key' do
    post '/api/v1/feedbacks', params: { message: 'This is a test' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(Feedback.all.count).to eq(0)
    expect(body.keys.length).to eq(1)

  end

end
