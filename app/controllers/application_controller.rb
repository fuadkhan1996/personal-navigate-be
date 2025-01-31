# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from CanCan::AccessDenied, with: :handle_access_denied
  rescue_from Aws::CognitoIdentityProvider::Errors::NotAuthorizedException, with: :not_authorized

  before_action :set_current_company
  before_action :authenticate_request!
  before_action :set_current_ability
  before_action :prepare_exception_notifier

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

  def handle_access_denied(exception)
    render json: { error: "Access denied: #{exception.message}" }, status: :forbidden
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

    Current.company_employee = current_company.active_company_employees_by_email(cognito_user[:email].to_s).first
    Current.access_token = token
  end

  def set_current_ability
    Current.ability = current_company_employee.try(:ability)
  end

  def not_found(exception)
    render json: { error: "Not found: #{exception.message}" }, status: :not_found
  end

  def parameter_missing(exception)
    render json: { error: "Parameter missing: #{exception.message}" }, status: :bad_request
  end

  def prepare_exception_notifier
    request.env['exception_notifier.exception_data'] = {
      CompanyId: current_company.try(:id) || 'Anonymous',
      CompanyTitle: current_company.try(:title) || 'Anonymous',
      CompanyEmployeeId: current_company_employee.try(:id) || 'Anonymous',
      EmployeeId: current_company_employee.try(:dc_employee_id) || 'Anonymous',
      Name: current_company_employee.try(:fullname) || 'Anonymous',
      Email: current_company_employee.try(:email) || 'Anonymous'
    }
  end
end
