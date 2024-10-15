# frozen_string_literal: true

module Api
  module V1
    module Employees
      class ProfilesController < ApplicationController
        def update_email
          if current_employee.update(update_email_params)
            render json: Dc::CompanyEmployeeBlueprint.render(current_company_employee, view: :extended), status: :ok
          else
            unprocessable_entity(current_employee.errors)
          end
        end

        def verify_email_update
          Cognito::Base.verify_email(user_object: { confirmation_code: }, access_token: current_access_token)
          render json: { message: 'Email verified successfully.' }, status: :ok
        rescue Aws::CognitoIdentityProvider::Errors::CodeMismatchException => e
          render json: { error: e.message }, status: :unprocessable_entity
        end

        def update
          if current_employee.update(update_params)
            render json: Dc::CompanyEmployeeBlueprint.render(current_company_employee, view: :extended), status: :ok
          else
            unprocessable_entity(current_employee.errors)
          end
        end

        private

        def update_email_params
          params.require(:employee).permit(:email)
        end

        def update_params
          params.require(:employee).permit(:first_name, :last_name)
        end

        def confirmation_code
          params.require(:employee).permit(:confirmation_code)[:confirmation_code]
        end
      end
    end
  end
end
