# frozen_string_literal: true

class AssociatedActivityBlueprint < ApplicationBlueprint
  api_identifier :id

  api_field :company_id, type: :string, required: true
  api_field :activity_id, type: :string, required: true
  api_field :pinned, type: :boolean, required: true
  api_field :completed_at, type: :string, required: false
  api_field :completed, type: :boolean, required: false do |record, _options|
    record.completed?
  end

  api_field :assessment_id, type: :string, required: false
  api_field :created_at, type: :string, required: false
  api_field :updated_at, type: :string, required: false

  api_association :activity, blueprint: ActivityBlueprint
  api_association :associated_activity_actions, blueprint: AssociatedActivity::ActionBlueprint, type: :array
  api_association :associated_activity_triggers, blueprint: AssociatedActivity::TriggerBlueprint, type: :array
end
