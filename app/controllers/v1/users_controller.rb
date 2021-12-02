class V1::UsersController < ApiController
  skip_before_action :authenticate_user, only: :create

  def create
    User.create!(user_params)
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
