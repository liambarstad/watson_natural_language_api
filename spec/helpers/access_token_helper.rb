module AccessTokenHelper

  def get_token
    user = User.create!(api_key: 'somestuff')
    post '/api/v1/access_tokens', params: { api_key: user.api_key }
    JSON.parse(response.body)['token']
  end

end
