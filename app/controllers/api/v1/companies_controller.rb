# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      def index
        scope = if params[:company_type].present?
                  current_company.linked_companies_by_company_type(params[:company_type])
                else
                  current_company.linked_companies
                end

        @companies = scope.includes(:company_type).order(created_at: :desc)
        render json: Dc::CompanyBlueprint.render(@companies, view: :with_primary_company_employee), status: :ok
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
    end
  end
end
