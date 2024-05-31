# frozen_string_literal: true

class ActivityBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :description, :deleted_at, :created_at, :updated_at

  view :normal do
    association :activity_actions, blueprint: Activity::ActionBlueprint
  end
end
