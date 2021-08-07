module Errors
  extend ActiveSupport::Concern

  included do
    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, with: :render_500_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActionController::RoutingError, with: :render_not_found
      rescue_from ActionController::ParameterMissing, with: :render_missing_param
      rescue_from ActionController::InvalidAuthenticityToken, with: :render_500_error
    end
  end

  # render 500 error
  def render_500_error(failsafe_error)
    logger.error "Error during failsafe response: #{failsafe_error}\n  #{failsafe_error.backtrace * "\n  "}"
    render_error('api.errors.technical_error')
  end

  # render 404 error
  def render_not_found
    render_error('api.errors.not_found')
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def render_error(msg, errors = nil, status = :unprocessable_entity, error_type = 'api')
    err = { message: I18n.t(msg), type: error_type }
    err[:data] =  errors.blank? ? '' : serialize(errors)
    render json: { error: err }, status: status
  end

  def serialize(errors)
    return errors if errors.class.eql?(Array) # not active record errors
    details = []
    errors.details.map do |k, v|
      v.each do |error_code|
        if error_code[:error].present? && error_code[:error].class == String
          details.push(error_code[:error])
        else
          details.push(errors.generate_message(k, error_code[:error]))
        end
      end
    end
    details.join(',')
  end
end