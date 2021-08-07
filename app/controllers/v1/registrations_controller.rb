class V1::RegistrationsController < Devise::RegistrationsController
  include Serializable
  respond_to :json

  def create
    super do
      render json: {data: render_serializable(resource, Post)} and return
    end
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :sure_name)
  end
end