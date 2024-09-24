# frozen_string_literal: true

module Dc
  class CompanyEmployeeBlueprint < Blueprinter::Base
    identifier :id

    fields :email, :first_name, :last_name, :uuid, :created_at, :updated_at
    association :company, blueprint: Dc::CompanyBlueprint
  end
end
