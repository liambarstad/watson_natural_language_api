require 'rails_helper'

RSpec.describe 'User can add feedback', type: :request do
  
  it 'with valid credentials' do
    post '/api/v1/feedbacks', params: { message: 'This is a test' }

    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body['message']).to eq('This is a test')
    expect(Feedback.all.count).to eq(1)
    expect(Feedback.first.message).to eq('This is a test')
  end

end
