require 'rails_helper'

RSpec.describe 'Admin can find all feedbacks with specific tone' do
  before :each do
    create(:tone, emotion: 'joy')
    create(:tone, emotion: 'sadness')
    create(:joyful_feedback)
    create(:sad_feedback)
  end

  describe 'with correct token' do
    
    let!(:token) { get_token(admin: true) }

    it 'with joyful tone' do
      get '/api/v1/feedbacks', params: { tone: 'joy', token: token }

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body.length).to eq(1)
      expect(body[0]['tone']).to eq('joy')
    end

    it 'with sad tone' do
      get '/api/v1/feedbacks', params: { tone: 'sadness', token: token }

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body.length).to eq(1)
      expect(body[0]['tone']).to eq('sadness')
    end
  end

  it 'as a base level user' do
    token = get_token
    get '/api/v1/feedbacks', params: { tone: 'joy', token: token }

    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(body.keys.length).to eq(1)
  end

  it 'with no token' do
    get '/api/v1/feedbacks', params: { tone: 'joy' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(body.keys.length).to eq(1)
  end
end
