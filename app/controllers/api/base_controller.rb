class Api::BaseController < ApplicationController

  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def generate_token(user)
    JWT.encode({ user_id: user.id }, jwt_key, "HS256")
  end

  def decoded_token
    begin
      JWT.decode(token, jwt_key, true, { algorithm: 'HS256' })
    rescue => exception
      [{error: "Invalid Token"}]
    end    
  end

  def current_user
    @user ||= User.find_by(id: user_id)
  end

  def logged_in?
    !!current_user
  end

  private

  def current_order
    @current_order ||= current_user.active_order
  end

  def user_id
    decoded_token.first["user_id"]
  end

  def token
    request.headers["X-Auth-Token"]
  end

  def jwt_key
    Rails.application.credentials.jwt_key
  end

  def not_found
    render json: "Record Not Found", status: 404
  end
end
