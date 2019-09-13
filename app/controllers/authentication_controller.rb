class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  #Return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:name], auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:name, :email, :password)
  end

end
