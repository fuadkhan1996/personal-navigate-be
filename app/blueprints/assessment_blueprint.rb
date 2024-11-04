# frozen_string_literal: true

class AssessmentBlueprint < ActivityBlueprint
  identifier :id

  fields :id, :title, :tis_order_id, :completed_at, :status, :form_data, :deleted_at, :created_at, :updated_at
  association :account, blueprint: Dc::CompanyBlueprint, with: :with_primary_company_employee

  view :with_action_results do
    association :assessment_action_results,
                blueprint: Assessment::ActionResultBlueprint,
                view: :with_activities do |assessment, _options|
      assessment.assessment_action_results.active
    end
  end
end
