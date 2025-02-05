# frozen_string_literal: true

class Assessment
  class ActionResultBlueprint < ApplicationBlueprint
    identifier :id

    fields :activity_action_id,
           :associated_activity_id,
           :assessment_id,
           :result_data,
           :deleted_at,
           :completed_at,
           :status,
           :created_at,
           :updated_at

    association :activity_triggers, blueprint: Activity::TriggerBlueprint
    association :activity_action, blueprint: Activity::ActionBlueprint, view: :with_supporting_documents

    view :with_activities do
      association :activities, blueprint: ActivityBlueprint, view: :extended
    end
  end
end
