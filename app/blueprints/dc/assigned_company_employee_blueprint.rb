# frozen_string_literal: true

module Dc
  class AssignedCompanyEmployeeBlueprint < ApplicationBlueprint
    api_identifier :id

    api_association :company_employee, blueprint: Dc::CompanyEmployeeBlueprint
  end
end
