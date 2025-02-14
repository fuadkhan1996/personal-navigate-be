# frozen_string_literal: true

class AssociatedActivityBlueprint < ApplicationBlueprint
  identifier :id

  fields :company_id, :activity_id, :pinned, :completed_at, :completed?, :assessment_id, :created_at, :updated_at

  api_association :activity, blueprint: ActivityBlueprint
  api_association :associated_activity_actions, blueprint: AssociatedActivity::ActionBlueprint
  api_association :associated_activity_triggers, blueprint: AssociatedActivity::TriggerBlueprint
end
