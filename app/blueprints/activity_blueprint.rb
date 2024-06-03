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
end
