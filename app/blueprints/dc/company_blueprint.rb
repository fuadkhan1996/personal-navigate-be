# frozen_string_literal: true

module Dc
  class CompanyBlueprint < ApplicationBlueprint
    identifier :id

    fields :id, :guid, :title, :logo, :company_type_name, :deleted_at, :created_at, :updated_at

    view :with_primary_company_employee do
      association :primary_company_employee, blueprint: Dc::CompanyEmployeeBlueprint
      api_association :assigned_company_employees, blueprint: Dc::AssignedCompanyEmployeeBlueprint
    end
  end
end
