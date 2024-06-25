# frozen_string_literal: true

class Assessment
  class ActionResultBlueprint < Blueprinter::Base
    identifier :id

    fields :activity_action_id,
           :assessment_id,
           :activity_trigger_id,
           :result_data,
           :deleted_at,
           :created_at,
           :updated_at

    association :activity, blueprint: ActivityBlueprint, view: :extended
    association :activity_trigger, blueprint: Activity::TriggerBlueprint
    association :activity_action, blueprint: Activity::ActionBlueprint
  end
end
