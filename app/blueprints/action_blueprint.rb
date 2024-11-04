# frozen_string_literal: true

class ActionBlueprint < ApplicationBlueprint
  identifier :id

  fields :title, :description, :action_kind, :created_at, :updated_at
end
