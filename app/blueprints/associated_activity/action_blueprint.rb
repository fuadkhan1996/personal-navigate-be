# frozen_string_literal: true

class AssociatedActivity
  class ActionBlueprint < ApplicationBlueprint
    api_identifier :id

    api_field :activity_action_id, type: :string, required: true
    api_field :associated_activity_id, type: :string, required: true
    api_field :result_data, type: :object, required: true
    api_field :deleted_at, type: :string, required: true
    api_field :completed_at, type: :string, required: true
    api_field :status, type: :string, required: true
    api_field :created_at, type: :string, required: true
    api_field :updated_at, type: :string, required: true

    api_association :activity_action, blueprint: Activity::ActionBlueprint, view: :with_supporting_documents
  end
end
