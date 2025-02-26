# frozen_string_literal: true

class TriggerBlueprint < ApplicationBlueprint
  api_identifier :id

  api_field :description, type: :string, required: true
  api_field :criteria, type: :object, required: true
  api_field :questionnaire_title, type: :string, required: true
  api_field :deleted_at, type: :string, required: true
  api_field :created_at, type: :string, required: true
  api_field :updated_at, type: :string, required: true

  api_view :extended do
    api_association :company_employee, blueprint: Dc::CompanyEmployeeBlueprint
  end
end
