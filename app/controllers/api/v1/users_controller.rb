class Api::V1::UsersController < ApplicationController
  
  def create
    @user = User.find_or_create_by(user_params)
    render json: @user.token
  end

  private

    def user_params
      params.permit(:username)
    end

end