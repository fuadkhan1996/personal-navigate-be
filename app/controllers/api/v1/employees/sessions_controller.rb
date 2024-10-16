# frozen_string_literal: true

module Api
  module V1
    module Employees
      class SessionsController < ApplicationController
        skip_before_action :set_current_company, only: %i[create]
        skip_before_action :authenticate_request!, only: %i[create refresh]

        def show
          render json: Dc::CompanyEmployeeBlueprint.render(current_company_employee, view: :extended), status: :ok
        end

        def create
          response = Dc::Employee.authenticate(sign_in_params[:email], sign_in_params[:password])
          if response[:access_token]
            render_successful_authentication(response)
          else
            invalid_credentials
          end
        end

        def refresh
          employee = Dc::Employee.find_by(email: refresh_params[:email].to_s)
          response = Dc::Employee.refresh_access_token(
            employee.try(:cognito_username),
            refresh_params[:refresh_token]
          )

          if response[:access_token]
            render json: {
              access_token: response[:access_token],
              token_expires_in: response[:token_expires_in]
            }, status: :created
          else
            not_authorized
          end
        end

        private

        def sign_in_params
          params.require(:employee).permit(:email, :password, :entity_type)
        end

        def refresh_params
          params.require(:session).permit(:refresh_token, :email)
        end

        def render_successful_authentication(response)
          employee = find_employee
          render json: Dc::CompanyEmployeeBlueprint.render_as_hash(employee, view: :extended).merge(response),
                 status: :created
        end

        def find_employee
          if sign_in_params[:entity_type].present?
            find_employee_by_entity_type
          else
            find_employee_without_entity_type
          end
        end

        def find_employee_by_entity_type
          Dc::CompanyEmployee.find_for_email_and_company_type(
            email: sign_in_params[:email].to_s,
            company_type_name: sign_in_params[:entity_type].to_s
          )
        end

        def find_employee_without_entity_type
          Dc::CompanyEmployee.by_email(sign_in_params[:email].to_s)
                             .order_by_created_at
                             .first
        end
      end
    end
  end
end
