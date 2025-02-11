# frozen_string_literal: true

class AssociatedActivity
  class ActionBlueprint < ApplicationBlueprint
    identifier :id

    fields :activity_action_id,
           :associated_activity_id,
           :result_data,
           :deleted_at,
           :completed_at,
           :status,
           :created_at,
           :updated_at

    api_association :activity_action, blueprint: Activity::ActionBlueprint, view: :with_supporting_documents
  end
end
