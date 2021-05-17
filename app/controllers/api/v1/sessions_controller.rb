# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::BaseController

  def create
    user = User.find_for_database_authentication(email: params[:user] && params[:user][:email])
    if invalid_password?(user)
      render json: { error: "Incorrect email or password" }, status: 401
    else
      session[:user_id] = user.id
      render json: {
        user: user
      }
    end
  end

  def destroy
    reset_session
    render json: { logged_out: true }, status: 200 
  end

  private

    def invalid_password?(user)
      user.blank? || !user.valid_password?(params[:user][:password])
    end
end
