# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_accessor :current_employee

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  before_action :authenticate_request!

  protected

  def unprocessable_entity(errors)
    render json: { errors: errors.to_h }, status: :unprocessable_entity
  end

  def invalid_credentials
    render json: { error: 'Invalid Email Or Password.' }, status: :unauthorized
  end

  def not_authorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end

  private

  def authenticate_request!
    auth_header = request.headers['Authorization']
    return not_authorized if auth_header.blank?

    athenticate_token!(auth_header.split[-1]) || not_authorized
  end

  def athenticate_token!(token)
    # rubocop:disable Rails/DynamicFindBy
    self.current_employee = Dc::Employee.find_by_access_token(token)
    # rubocop:enable Rails/DynamicFindBy
  end

  def not_found(exception)
    render json: { error: "Not found: #{exception.message}" }, status: :not_found
  end

  def parameter_missing(exception)
    render json: { error: "Parameter missing: #{exception.message}" }, status: :bad_request
  end
end
