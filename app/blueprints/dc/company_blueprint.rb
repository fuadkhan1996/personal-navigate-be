# frozen_string_literal: true

module Dc
  class CompanyBlueprint < ApplicationBlueprint
    api_identifier :id

    api_field :guid, type: :string, required: true
    api_field :title, type: :string, required: true
    api_field :logo, type: :string, required: true
    api_field :company_type_name, type: :string, required: true
    api_field :deleted_at, type: :string, required: true
    api_field :created_at, type: :string, required: true
    api_field :updated_at, type: :string, required: true

    api_view :with_primary_company_employee do
      api_association :primary_company_employee, blueprint: Dc::CompanyEmployeeBlueprint
      api_association :assigned_company_employees, blueprint: Dc::AssignedCompanyEmployeeBlueprint, type: :array
    end
  end
end
