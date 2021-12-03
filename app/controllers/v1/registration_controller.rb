class V1::RegistrationController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    @user = User.new(user_params)
    return render json: @user.errors, status: :unprocessable_entity unless @user.save

    command = AuthenticateUser.call(params[:email], params[:password])
    render json: { auth_token: command.result } if command.success?
  end

  private

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
