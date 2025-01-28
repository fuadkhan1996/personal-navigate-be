# frozen_string_literal: true

module Api
  module V1
    module Companies
      class AssignedCompanyEmployeesController < ApplicationController
        before_action :validate_company_employee!
        before_action :validate_company!
        before_action :set_assigned_company_employee, only: :destroy

        def create
          @assigned_company_employee = company_connection.assigned_company_employees.new(create_params)
          if @assigned_company_employee.save
            render json: Dc::CompanyBlueprint.render(company.reload, view: :with_primary_company_employee),
                   status: :created
          else
            unprocessable_entity(@assigned_company_employee.errors.messages)
          end
        end

        def destroy
          @assigned_company_employee.destroy
          render json: Dc::CompanyBlueprint.render(company.reload, view: :with_primary_company_employee), status: :ok
        end

        private

        def create_params
          params.permit(assigned_company_employee: [:company_employee_id]).require(:assigned_company_employee)
        end

        def company
          @company ||= current_company.linked_companies
                                      .includes(assigned_company_employees: { company_employee: :employee })
                                      .find_by(id: params[:company_id])
        end

        def validate_company!
          return if company.present?

          raise ActiveRecord::RecordNotFound, "Company could not be found with ID: #{params[:company_id]}."
        end

        def company_connection
          @company_connection ||= Dc::CompanyConnection.find_connection_between(current_company.id,
                                                                                company.id)
        end

        def validate_company_employee!
          return if company_connection.present?

          raise ActiveRecord::RecordNotFound,
                "Company connection could not be found for the provided Company ID: #{company.id}."
        end

        def set_assigned_company_employee
          @assigned_company_employee = company_connection.assigned_company_employees.find_by(id: params[:id])
          return if @assigned_company_employee.present?

          raise ActiveRecord::RecordNotFound, "Assigned Company Employee could not be found with ID #{params[:id]}."
        end
      end
    end
  end
end
