module AuthenticationHelper
  
  def get_token(options={})
    user = options[:admin] ?
      create(:user, role: 'admin') :
      create(:user) ;
    post '/api/v1/access_tokens', params: { api_key: user.api_key }
    JSON.parse(response.body)['token']
  end

  def get_api_key(token=nil)
    token ||= get_token
    access_token = AccessToken.find_by(token: token)
    access_token.user.api_key
  end

end
