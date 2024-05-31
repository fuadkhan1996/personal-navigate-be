# frozen_string_literal: true

class ActionBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :description, :created_at, :updated_at
end
