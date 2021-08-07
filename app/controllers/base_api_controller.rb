class BaseApiController < ApplicationController
  include Serializable
  include Errors

  protected
  def authenticate_user_from_token!
    if jwt_user.present?
      @current_user = jwt_user
    else
      render_error('api.errors.unauthorized', nil, :unauthorized)
    end
  end

  def jwt_payload
    @jwt_payload ||= begin
      JsonWebToken.decode(jwt_token)
    rescue
      nil
    end
  end

  def jwt_user
    @jwt_user ||= begin
      User.where(id: jwt_payload[0]['user']['id']).first
    rescue
      nil
    end
  end

  def jwt_token
    @jwt_token ||= begin
      auth_header = request.headers['Authorization']
      auth_header.split(' ').last
    rescue
      nil
    end
  end
end