# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  protected

  def unprocessable_entity(errors)
    render json: { errors: errors.to_h }, status: :unprocessable_entity
  end

  def invalid_credentials
    render json: { error: 'Invalid Email Or Password.' }, status: :unauthorized
  end

  private

  def not_found(exception)
    render json: { error: "Not found: #{exception.message}" }, status: :not_found
  end

  def parameter_missing(exception)
    render json: { error: "Parameter missing: #{exception.message}" }, status: :bad_request
  end
end
