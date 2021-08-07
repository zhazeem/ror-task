class V1::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    puts sign_in_params[:email]
    puts resource_name
    resource = User.find_for_database_authentication(email: sign_in_params[:email])
    return invalid_login_attempt unless resource
    if resource.valid_password?(sign_in_params[:password])
      sign_in(resource_name, resource)
      render json: resource
    else
      invalid_login_attempt
    end
  end

  protected
  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

  def resource_name
    :user
  end
end