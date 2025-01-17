# frozen_string_literal: true

module Api
  module V1
    module CompanyEmployees
      class InvitationsController < ApplicationController
        skip_before_action :set_current_company, only: %i[show update]
        skip_before_action :authenticate_request!, only: %i[show update]
        before_action :set_company_employee, only: %i[show update]

        def show
          if @company_employee.present?
            render json: Dc::CompanyEmployeeBlueprint.render(@company_employee, view: :extended), status: :ok
          else
            not_authorized
          end
        end

        def create
          @company_employee = CreateEmployeeService.new(params: create_invitation_params).call_with_invitation
          if @company_employee.errors.any?
            unprocessable_entity(@company_employee.errors.messages)
          else
            render json: Dc::CompanyEmployeeBlueprint.render(@company_employee, view: :extended), status: :created
          end
        end

        def update
          employee.assign_attributes(accept_invitation_params)
          if employee.valid?
            create_cognito_user
            @company_employee.accept_invitation!
            render json: Dc::CompanyEmployeeBlueprint.render(@company_employee, view: :extended), status: :ok
          else
            unprocessable_entity(employee.errors.messages)
          end
        end

        def resend_invite
          @company_employee = Dc::CompanyEmployee.find_by(id: params[:id])
          if @company_employee.invitation_accepted?
            render json: { error: 'Invitation Accepted Already.' }, status: :unprocessable_entity
          else
            @company_employee.invite!(current_company_employee)
            render json: Dc::CompanyEmployeeBlueprint.render(@company_employee), status: :ok
          end
        end

        def bulk_invite
          response = CreateEmployeesService.new(params: bulk_invite_params).call
          if response.status == :success
            render json: { message: response.message }, status: :ok
          else
            unprocessable_entity(response.errors.messages)
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
          params.require(:employee).permit(
            :first_name,
            :last_name,
            :password,
            :password_confirmation
          ).merge(should_validate_name_presence: true)
        end

        def create_invitation_params
          params.require(:company_employee).permit(
            :employee_type,
            employee_attributes: %i[first_name last_name email]
          ).merge(dc_company_id: current_company.id)
        end

        def bulk_invite_params
          params.require(:invitation).permit(
            :employee_type,
            email_addresses: []
          ).merge(dc_company_id: current_company.id)
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
