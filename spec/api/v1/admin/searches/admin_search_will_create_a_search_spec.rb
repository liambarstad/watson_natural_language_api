require 'rails_helper'

RSpec.describe 'Admin search will create a search', type: :request do

  let!(:english) { create(:language, abbr: 'en', name: 'English') }
  let!(:joy) { create(:tone, emotion: 'joy') }
  let!(:token) { get_token(admin: true) }
  let!(:api_key) { get_api_key(token) }

  describe 'on feedbacks controller' do
    it 'with valid search' do
      get '/api/v1/feedbacks', params: { language: 'en', tone: 'joy', token: token, api_key: api_key }

      searches = Search.all

      expect(searches.count).to eq(1)
      expect(searches.first.resource).to eq('feedback')
      expect(searches.first.language).to eq(english)
      expect(searches.first.tone).to eq(joy)
      expect(searches.first.ip_address).to_not be(nil)
    end

    it 'not without authentication' do
      get '/api/v1/feedbacks', params: { language: 'en', tone: 'joy' }

      searches = Search.all

      expect(searches.count).to eq(0)
    end

    it 'not with invalid search' do
      get '/api/v1/feedbacks', params: { language: 'fr', tone: 'joy', token: token, api_key: api_key }

      searches = Search.all

      expect(searches.count).to eq(0)
    end

  end

end
