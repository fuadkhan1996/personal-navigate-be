# frozen_string_literal: true

class Activity
  class ActionBlueprint < Blueprinter::Base
    identifier :id

    fields :title, :description, :details, :action_kind, :order, :created_at, :updated_at
  end
end
