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
    end
  end
end
