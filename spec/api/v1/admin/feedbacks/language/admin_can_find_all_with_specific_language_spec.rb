require 'rails_helper'

RSpec.describe 'Admin can find all feedbacks with specific language' do
  
  before :each do
    create(:language, abbr: 'en', name: 'English')
    create(:language, abbr: 'fr', name: 'French')
    create(:english_feedback)
    create(:french_feedback)
  end
  
  describe 'with correct token' do

    before :each do
      let!(:token) { get_token(admin: true) }
    end

    it 'with english language' do
      get '/api/v1/feedbacks', params: { lang: 'en', token: token } 

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body.length).to eq(1)
    end

    it 'with french language' do
      get '/api/v1/feedbacks', params: { lang: 'fr', token: token } 

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body.length).to eq(1)
    end

    it 'with unlisted language' do
      get '/api/v1/feedbacks', params: { lang: 'nada', token: token } 

      body = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(body['error']).to eq('Language not listed')
      expect(body.keys.length).to eq(1)
    end

  end

  it 'with base user token' do
    token = get_token
    get '/api/v1/feedbacks', params: { lang: 'en', token: token } 
    
    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(body.keys.length).to eq(1)
  end

end
