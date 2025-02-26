# frozen_string_literal: true

class Activity
  class TriggerBlueprint < ApplicationBlueprint
    api_identifier :id

    api_field :activity_id, type: :string, required: false
    api_field :trigger_id, type: :string, required: true
    api_field :created_at, type: :string, required: true
    api_field :updated_at, type: :string, required: true
    api_association :trigger, blueprint: ::TriggerBlueprint

    api_view :extended do
      api_association :activity, blueprint: ::ActivityBlueprint, view: :normal
    end
  end
end
