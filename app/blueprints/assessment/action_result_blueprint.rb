# frozen_string_literal: true

class Assessment
  class ActionResultBlueprint < ApplicationBlueprint
    api_identifier :id

    api_field :activity_action_id, type: :string
    api_field :associated_activity_id, type: :string
    api_field :assessment_id, type: :string
    api_field :result_data, type: :string
    api_field :deleted_at, type: :string
    api_field :completed_at, type: :string
    api_field :status, type: :string
    api_field :created_at, type: :string
    api_field :updated_at, type: :string

    api_association :activity_triggers, blueprint: Activity::TriggerBlueprint, type: :array
    api_association :activity_action, blueprint: Activity::ActionBlueprint, view: :with_supporting_documents

    api_view :with_activities do
      api_association :activities, blueprint: ActivityBlueprint, view: :extended, type: :array
    end
  end
end
