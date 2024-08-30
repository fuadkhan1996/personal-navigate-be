# frozen_string_literal: true

module Api
  module V1
    module Employees
      class SessionsController < ApplicationController
        skip_before_action :authenticate_request!, only: %i[create refresh]

        def show
          render json: Dc::EmployeeBlueprint.render(employee), status: :ok
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
          # rubocop:disable Rails/DynamicFindBy
          dc_employee = Dc::Employee.find_by_email(refresh_params[:email])
          # rubocop:enable Rails/DynamicFindBy

          response = Dc::Employee.refresh_access_token(
            dc_employee.try(:cognito_username),
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
          employee = Dc::Employee.lookup_by_email_and_company_type(
            sign_in_params[:email].to_s,
            sign_in_params[:entity_type].to_s
          )

          render json: Dc::Company::EmployeeBlueprint.render_as_hash(employee).merge(response), status: :created
        end
      end
    end
  end
end
