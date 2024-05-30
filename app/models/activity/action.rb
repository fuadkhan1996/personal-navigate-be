# frozen_string_literal: true

class Activity
  class Action < ApplicationRecord
    self.table_name = :nav_activity_actions

    belongs_to :activity,
               class_name: '::Activity',
               foreign_key: :nav_activity_id,
               inverse_of: :activity_actions

    belongs_to :action, class_name: '::Action', foreign_key: :nav_action_id, inverse_of: :activity_actions
    has_many_attached :supporting_documents
    has_many :assessment_action_results,
             dependent: :restrict_with_exception,
             class_name: '::Assessment::ActionResult',
             foreign_key: :nav_activity_action_id,
             inverse_of: :activity_action
  end
end
