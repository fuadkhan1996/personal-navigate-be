# frozen_string_literal: true

class ActivityBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :title, :description, :deleted_at, :created_at, :updated_at
  end

  view :extended do
    include_view :normal
    association :activity_actions, blueprint: Activity::ActionBlueprint
    association :activity_triggers, blueprint: Activity::TriggerBlueprint
  end

  view :with_assessment_action_results do
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

    association :assessment_action_results, blueprint: Assessment::ActionResultBlueprint
  end
end
