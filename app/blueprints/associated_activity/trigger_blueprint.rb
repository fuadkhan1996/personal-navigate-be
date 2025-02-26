# frozen_string_literal: true

class AssociatedActivity
  class TriggerBlueprint < ApplicationBlueprint
    api_identifier :id

    api_field :activity_trigger_id, type: :string, required: true
    api_field :associated_activity_id, type: :string, required: true
    api_field :created_at, type: :string, required: true
    api_field :updated_at, type: :string, required: true

    api_association :trigger, blueprint: ::TriggerBlueprint
  end
end
