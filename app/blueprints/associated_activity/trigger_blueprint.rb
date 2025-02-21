# frozen_string_literal: true

class AssociatedActivity
  class TriggerBlueprint < ApplicationBlueprint
    identifier :id

    fields :activity_trigger_id,
           :associated_activity_id,
           :created_at,
           :updated_at

    api_association :activity_trigger, blueprint: Activity::TriggerBlueprint
  end
end
