require 'rails_helper'

RSpec.describe 'Admin can get access token', type: :request do
  
  it 'with existing admin account' do
    admin = create(:user, role: 'admin')
    post '/api/v1/access_tokens', params: { api_key: admin.api_key  }

    body = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(body['token']).to_not be(nil)
    expect(body.keys.length).to be(1)

    content = JWTService.decode(body['token'], admin.api_key)

    expect(content['id']).to eq(admin.id)
    expect(content['expiry']).to be > Time.now.to_i
  end

end
