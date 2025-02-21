# frozen_string_literal: true

module Dc
  class AssignedCompanyEmployeeBlueprint < ApplicationBlueprint
    identifier :id

    api_association :company_employee, blueprint: Dc::CompanyEmployeeBlueprint
  end
end
