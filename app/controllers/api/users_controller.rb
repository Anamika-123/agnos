class Api::UsersController < Api::BaseController

  def create
    user = User.new(user_params)

    if user.save
      render json: user.as_json
    else
      render json: { error: user.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :email)
  end
end