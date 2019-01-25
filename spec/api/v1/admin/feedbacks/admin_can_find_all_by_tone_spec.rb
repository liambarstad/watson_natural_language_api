require 'rails_helper'

RSpec.describe 'Admin can find all feedbacks with specific tone' do
  let!(:english) { create(:language, abbr: 'en', name: 'English') }
  let!(:french) { create(:language, abbr: 'fr', name: 'French') }
  let!(:joy) { create(:tone, emotion: 'joy') }
  let!(:sadness) { create(:tone, emotion: 'sadness') }

  before :each do
    create(:feedback, language: english, tone: joy)
    create(:feedback, language: english, tone: sadness)
    create(:feedback, language: french, tone: sadness)
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
      expect(body.length).to eq(2)
      expect(body[0]['tone']).to eq('sadness')
      expect(body[1]['tone']).to eq('sadness')
    end

    it 'with unlisted tone' do
      get '/api/v1/feedbacks', params: { tone: 'haughty', token: token }

      body = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(body['error']).to eq('Tone not listed')
      expect(body.keys.length).to eq(1)
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
