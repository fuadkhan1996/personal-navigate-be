# frozen_string_literal: true

module Api
  module V1
    class CompanyEmployeesController < ApplicationController
      before_action :set_company
      before_action :set_company_employee, only: :update

      def index
        scope = if params[:employee_type].present?
                  @company.active_company_employees_by_employee_type(params[:employee_type])
                else
                  @company.active_company_employees
                end

        @company_employees = scope.order_by_created_at(:desc).includes(:employee)
        render json: Dc::CompanyEmployeeBlueprint.render(@company_employees), status: :ok
      end

      def update
        if @company_employee.update(update_params)
          render json: Dc::CompanyEmployeeBlueprint.render(@company_employee, view: :extended), status: :ok
        else
          unprocessable_entity(@company_employee.errors.messages)
        end
      end

      private

      def set_company_employee
        @company_employee = @company.active_company_employees.find_by(id: params[:id])
        return if @company_employee.present?

        raise ActiveRecord::RecordNotFound, "Company Employee could not be found with ID: #{params[:id]}."
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

      def set_company
        @company = current_company if params[:company_id].blank?
        return if @company.present?

        @company = current_company.linked_companies.accessible_by(current_ability).find_by(id: params[:company_id])
        return if @company.present?

        raise ActiveRecord::RecordNotFound, "Company could not be found with ID: #{params[:company_id]}."
      end
    end
  end
end
