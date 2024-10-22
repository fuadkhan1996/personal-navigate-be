# frozen_string_literal: true

module Dc
  class CompanyBlueprint < Blueprinter::Base
    identifier :id

    fields :id, :guid, :title, :logo, :company_type_name, :deleted_at, :created_at, :updated_at

    view :with_primary_company_employee do
      association :primary_company_employee, blueprint: Dc::CompanyEmployeeBlueprint
    end
  end
end
