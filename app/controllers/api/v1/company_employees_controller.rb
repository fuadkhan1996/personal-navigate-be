# frozen_string_literal: true

module Api
  module V1
    class CompanyEmployeesController < ApplicationController
      before_action :set_company_employee

      def update
        if @company_employee.update(update_params)
          render json: Dc::CompanyEmployeeBlueprint.render(@company_employee), status: :ok
        else
          unprocessable_entity(@company_employee.errors.messages)
        end
      end

      private

      def set_company_employee
        @company_employee = current_company.company_employees.find(params[:id])
      end

      def update_params
        permitted_params = params.require(:company_employee).permit(
          employee_attributes: %i[first_name last_name]
        )

        permitted_params.tap do |params|
          next unless params[:employee_attributes]

          params[:employee_attributes][:id] = @company_employee.dc_employee_id
        end
      end
    end
  end
end
