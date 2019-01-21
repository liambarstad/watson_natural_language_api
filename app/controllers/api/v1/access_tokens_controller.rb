class Api::V1::AccessTokensController < ApplicationController
  
  def create
    user = User.find_by(user_params)
    if user
      user.generate_access_token
      @access_token = user.access_token
      render json: @access_token
    else
      render status: 400, json: { error: 'API Key Invalid' }.to_json
    end
  end

  private

    def user_params
      params.permit(:api_key)
    end

end
