class V1::RegistrationController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @user = User.new
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save!
      command = AuthenticateUser.call(params[:email], params[:password])
      render json: { auth_token: command.result }
    end
  end
end