# frozen_string_literal: true

class Activity
  class TriggerBlueprint < Blueprinter::Base
    identifier :id

    fields :title, :description, :criteria, :questionnaire_title, :deleted_at, :created_at, :updated_at

    view :extended do
      association :activity, blueprint: ::ActivityBlueprint, view: :normal
    end
  end
end
