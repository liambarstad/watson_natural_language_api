require 'rails_helper'

RSpec.describe 'Admin can find all feedbacks with specific language' do
  let!(:english) { create(:language, abbr: 'en', name: 'English') }
  let!(:french) { create(:language, abbr: 'fr', name: 'French') }

  before :each do
    create(:feedback, language: english)
    create(:feedback, language: french)
  end
  
  it 'with base user token' do
    token = get_token
    get '/api/v1/feedbacks', params: { language: 'en', token: token } 
    
    body = JSON.parse(response.body)

    expect(response.status).to eq(401)
    expect(body['error']).to eq('Unauthorized')
    expect(body.keys.length).to eq(1)
  end

  describe 'with correct token' do

    let!(:token) { get_token(admin: true) }

    it 'with english language' do
      get '/api/v1/feedbacks', params: { language: 'en', token: token } 

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body.length).to eq(1)
      expect(body[0]['language']).to eq('en')
    end

    it 'with french language' do
      get '/api/v1/feedbacks', params: { language: 'fr', token: token } 

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body.length).to eq(1)
      expect(body[0]['language']).to eq('fr')
    end

    it 'with unlisted language' do
      get '/api/v1/feedbacks', params: { language: 'nada', token: token } 

      body = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(body['error']).to eq('Language not listed')
      expect(body.keys.length).to eq(1)
    end

  end

end
