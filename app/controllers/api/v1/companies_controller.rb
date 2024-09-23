# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      def index
        @companies = if params[:company_type].present?
                       current_company.linked_companies_by_company_type(params[:company_type]).includes(:company_type)
                     else
                       current_company.linked_companies.includes(:company_type)
                     end

        render json: Dc::CompanyBlueprint.render(@companies), status: :ok
      end

      def create
        @company = CreateCompanyService.new(params: create_company_params).call
        if @company.errors.any?
          unprocessable_entity(@company.errors.messages)
        else
          render json: Dc::CompanyBlueprint.render(@company), status: :created
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
