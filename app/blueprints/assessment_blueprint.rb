# frozen_string_literal: true

class AssessmentBlueprint < ApplicationBlueprint
  identifier :id

  fields :id, :title, :tis_order_id, :completed_at, :status, :form_data, :deleted_at, :created_at, :updated_at
  association :account, blueprint: Dc::CompanyBlueprint, with: :with_primary_company_employee

  view :extended do
    api_association :associated_activities, blueprint: AssociatedActivityBlueprint
  end
end
