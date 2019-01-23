module AccessTokenHelper

  def get_token(options={})
    user = options[:admin] ?
      create(:user, role: 'admin') :
      create(:user) ;
    post '/api/v1/access_tokens', params: { api_key: user.api_key }
    JSON.parse(response.body)['token']
  end

end
