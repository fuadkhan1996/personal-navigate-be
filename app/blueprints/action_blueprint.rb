# frozen_string_literal: true

class ActionBlueprint < ApplicationBlueprint
  api_identifier :id

  api_field :title, type: :string, required: true
  api_field :description, type: :string, required: true
  api_field :action_kind, type: :string, required: true
  api_field :created_at, type: :string, required: true
  api_field :updated_at, type: :string, required: true
end
