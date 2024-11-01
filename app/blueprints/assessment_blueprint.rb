# frozen_string_literal: true

class ApplicationBlueprint < ActivityBlueprint
  identifier :id

  fields :id, :title, :tis_order_id, :completed_at, :status, :form_data, :deleted_at, :created_at, :updated_at
  association :account, blueprint: Dc::CompanyBlueprint, with: :with_primary_company_employee

  view :extended do
    association :assessment_action_results, blueprint: Assessment::ActionResultBlueprint, view: :with_activities
  end
end
