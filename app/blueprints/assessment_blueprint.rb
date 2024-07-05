# frozen_string_literal: true

class AssessmentBlueprint < Blueprinter::Base
  identifier :id

  fields :id, :title, :form_data, :deleted_at, :created_at, :updated_at
  association :account, blueprint: Dc::CompanyBlueprint

  view :extended do
    association :assessment_action_results, blueprint: Assessment::ActionResultBlueprint
  end
end
