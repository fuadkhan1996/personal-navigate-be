# frozen_string_literal: true

class AssessmentBlueprint < ApplicationBlueprint
  api_identifier :id

  api_field :title, type: :string, required: true
  api_field :tis_order_id, type: :string, required: true
  api_field :completed_at, type: :string, required: true
  api_field :status, type: :string, required: true
  api_field :form_data, type: :string, required: true
  api_field :deleted_at, type: :string, required: true
  api_field :created_at, type: :string, required: true
  api_field :updated_at, type: :string, required: true

  api_association :account, blueprint: Dc::CompanyBlueprint, view: :with_primary_company_employee
  api_view :extended do
    api_association :associated_activities, blueprint: AssociatedActivityBlueprint, type: :array
  end
end
