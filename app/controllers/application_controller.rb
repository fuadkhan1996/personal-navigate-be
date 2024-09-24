# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  before_action :set_current_company
  before_action :authenticate_request!

  include CurrentContextHelper

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

  def set_current_company
    company_id = request.headers['Company-Id']
    return if company_id.blank?

    Current.company = Dc::Company.find_by(guid: company_id)
  end

  def authenticate_request!
    auth_header = request.headers['Authorization']
    return not_authorized if auth_header.blank? && current_company.blank?

    athenticate_token!(auth_header.split[-1]) || not_authorized
  end

  def athenticate_token!(token)
    cognito_user = Cognito::Base.get_user(access_token: token.to_s)
    return if cognito_user.blank?

    Current.employee = current_company.company_employees_by_email(cognito_user[:email].to_s).first
  end

  def not_found(exception)
    render json: { error: "Not found: #{exception.message}" }, status: :not_found
  end

  def parameter_missing(exception)
    render json: { error: "Parameter missing: #{exception.message}" }, status: :bad_request
  end
end
