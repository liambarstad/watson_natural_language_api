require 'rails_helper'

RSpec.describe 'Admin can find all feedbacks by day' do
  let!(:english) { create(:language, abbr: 'en', name: 'English') }
  let!(:french) { create(:language, abbr: 'fr', name: 'French') }
  let!(:joy) { create(:tone, emotion: 'joy') }
  let(:sadness) { create(:tone, emotion: 'sadness') }
  
  before :each do
    create(:feedback, language: english, tone: sadness, created_at: Time.now - 60*60*24)
    create(:feedback, language: french, tone: joy, created_at: Time.now - 60*60*24)
    create(:feedback, language: english, tone: joy, created_at: Time.now - 60*60*24)
    create(:feedback, language: english, tone: joy)
    create(:feedback, language: french, tone: sadness)
  end

  it 'with base user token' do
    token = get_token
    get '/api/v1/feedbacks', params: { token: token, date: Time.now.strftime('%m-%d-%y') }

    body = JSON.parse(response.body)
    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(body.keys.length).to eq(1)
  end

  describe 'with correct token' do

    let!(:token) { get_token(admin: true) }

    it 'with valid date' do
      get '/api/v1/feedbacks', params: { token: token, date: Time.now.strftime('%m-%d-%Y') }

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body.length).to eq(2)
    end

    it 'with invalid date' do
      get '/api/v1/feedbacks', params: { token: token, date: '22-43-1002' }

      body = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(body['error']).to eq('Invalid date')
      expect(body.keys.length).to eq(1)
    end
  end
end
