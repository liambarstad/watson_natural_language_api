class Api::V1::ApiController < ApplicationController
  before_action :verify_user

  private
    
    def current_user
      @current_user
    end

    def verify_user
      token = AccessToken.find_by(token: params[:token])
      if token
        @current_user ||= token.user
      else
        render status: 401, json: { error: 'Unauthorized' }.to_json
      end
    end
end
