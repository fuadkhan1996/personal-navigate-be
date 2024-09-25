# frozen_string_literal: true

module Api
  module V1
    module CompanyEmployees
      class InvitationsController < ApplicationController
        skip_before_action :set_current_company, only: %i[show]
        skip_before_action :authenticate_request!, only: %i[show]
        before_action :set_company_employee

        def show
          if @company_employee.present?
            render json: Dc::CompanyEmployeeBlueprint.render(@company_employee), status: :ok
          else
            not_authorized
          end
        end

        def update
          employee.assign_attributes(accept_invitation_params)
          if employee.valid?
            create_cognito_user
            @company_employee.accept_invitation!
            render json: Dc::CompanyEmployeeBlueprint.render(@company_employee), status: :ok
          else
            unprocessable_entity(employee.errors.messages)
          end
        end

        private

        def set_company_employee
          # rubocop:disable Rails/DynamicFindBy
          @company_employee = Dc::CompanyEmployee.find_by_invitation_token(params[:invitation_token])
          # rubocop:enable Rails/DynamicFindBy
        end

        def employee
          @employee ||= @company_employee.employee
        end

        def accept_invitation_params
          params.require(:employee).permit(:password, :password_confirmation)
        end

        def user_object
          {
            username: @company_employee.email,
            password: accept_invitation_params[:password],
            phone_number: '+15555551234'
          }
        end

        def create_cognito_user
          Cognito::Base.admin_create_user(user_object:)
          Cognito::Base.admin_set_user_password(user_object: user_object.except(:phone_number))
        end
      end
    end
  end
end
