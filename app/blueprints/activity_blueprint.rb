# frozen_string_literal: true

class ActivityBlueprint < ApplicationBlueprint
  identifier :id

  view :normal do
    fields :title, :description, :deleted_at, :created_at, :updated_at
    association :company, blueprint: Dc::CompanyBlueprint
    association :company_employee, blueprint: Dc::CompanyEmployeeBlueprint
  end

  view :extended do
    include_view :normal
    association :activity_actions, blueprint: Activity::ActionBlueprint, view: :with_supporting_documents
    association :activity_triggers, blueprint: Activity::TriggerBlueprint do |activity, _options|
      activity.activity_triggers.active
    end
  end

  view :with_assessment_id_and_status do
    include_view :normal
    field :assessment_id, if: lambda { |_field_name, activity, _options|
      activity.respond_to?(:assessment_id) && activity.assessment_id.present?
    } do |activity, _options|
      activity.assessment_id
    end

    field :status, if: lambda { |_field_name, activity, _options|
      activity.respond_to?(:status) && activity.status.present?
    } do |activity, _options|
      activity.status
    end
  end

  view :with_assessment_action_results do
    include_view :with_assessment_id_and_status
    association :assessment_action_results, blueprint: Assessment::ActionResultBlueprint do |activity, options|
      assessment_ids = options[:assessment_ids]
      activity.assessment_action_results
              .by_assessments(assessment_ids)
              .includes(:activity_triggers, :activity_action)
    end
  end
end
