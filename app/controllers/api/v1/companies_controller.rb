# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :set_company, only: %i[show]

      def index
        scope = if params[:company_type].present?
                  current_company.linked_companies_by_company_type(params[:company_type])
                else
                  current_company.linked_companies
                end

        @companies = scope.accessible_by(current_ability).includes(:company_type)
                          .includes({ assigned_company_employees: { company_employee: :employee } })
                          .order(created_at: :desc)

        render json: Dc::CompanyBlueprint.render(@companies, view: :with_primary_company_employee), status: :ok
      end

      def show
        render json: Dc::CompanyBlueprint.render(@company, view: :with_primary_company_employee), status: :ok
      end

      def create
        @company = CreateCompanyService.new(params: create_company_params).call
        if @company.errors.any?
          unprocessable_entity(@company.errors.messages)
        else
          render json: Dc::CompanyBlueprint.render(@company, view: :with_primary_company_employee), status: :created
        end
      end

      private

      def create_company_params
        params.require(:company).permit(
          :title,
          :logo,
          :phone_number,
          :website,
          :company_type_name,
          employee_attributes: %i[first_name last_name email]
        )
      end

      def set_company
        @company = current_company.linked_companies
                                  .accessible_by(current_ability)
                                  .includes({ assigned_company_employees: { company_employee: :employee } })
                                  .find_by(id: params[:id])

        raise ActiveRecord::RecordNotFound, "Company with ID #{params[:id]}" if @company.blank?
      end
    end
  end
end
