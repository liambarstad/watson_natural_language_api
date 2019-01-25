class Api::V1::ApiController < ApplicationController
  before_action :verify_user

  private
    
    def auth_params
      params.permit(:token, :api_key)
    end
    
    def current_user
      @current_user
    end

    def verify_user
      payload = JWTService.decode(auth_params[:token], auth_params[:api_key])
      @current_user ||= User.find_by(id: payload['id'])
      unless current_user
        display_error 401, 'Unauthorized' 
      end
    end

    def verify_admin
      unless current_user.admin?
        display_error 401, 'Unauthorized'
      end
    end

end
