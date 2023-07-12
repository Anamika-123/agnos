class Api::SessionsController < Api::BaseController

  def create
    user = User.find_by_email(params[:email])

    if user && user.valid_password?(params[:password])
      render json: {
        token: generate_token(user),
        user: user.as_json
      }
    else
      render json: { error: "Incorrect email or password" }, status: 422
    end
  end
end
