class Api::V1::RegistrationsController < Api::V1::BaseController
  include CurrentUserConcern

  def create
    user = User.new(sign_up_params)
    if user.save
      session[:user_id] = user.id
      render json: {
        status: :created,
        user: user
      }
    else
      render json: {
        error: user.errors.full_messages
      }, status: 422
    end
  end

  def update_password
    debugger
    resource = User.find_by_email(params[:user][:email])
    if resource && resource.update_with_password(password_update_params)
      bypass_sign_in resource, scope: :user
      render json: { notice: 'Password has been successfully updated' }, status: :ok
    else
      render json: { error: "Couldn't update the password! Please try again." }, status: :unprocessable_entity
    end
  end

  private

    def sign_up_params
      resource_params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

    def password_update_params
      resource_params.permit(:password, :password_confirmation, :current_password)
    end

    def resource_params
      params.require(:user)
    end

end
