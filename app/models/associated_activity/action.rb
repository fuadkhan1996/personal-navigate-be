# frozen_string_literal: true

class AssociatedActivity
  class Action < ApplicationRecord
    self.table_name = :nav_assessment_action_results

    belongs_to :associated_activity, inverse_of: :associated_activity_actions
    belongs_to :activity_action,
               class_name: '::Activity::Action',
               foreign_key: :nav_activity_action_id,
               inverse_of: :assessment_action_results
    belongs_to :assessment,
               class_name: '::Assessment',
               foreign_key: :nav_assessment_id,
               inverse_of: :assessment_action_results,
               optional: true

    has_one :action, through: :activity_action
    has_many :assessment_action_result_triggers,
             dependent: :destroy,
             class_name: 'Assessment::ActionResultTrigger',
             foreign_key: :assessment_action_result_id,
             inverse_of: :assessment_action_result

    has_many :activity_triggers, through: :assessment_action_result_triggers

    def activity_action_id
      nav_activity_action_id
    end

    def assessment_id
      nav_assessment_id
    end

    def status
      completed_at.present? ? 'Complete' : 'Incomplete'
    end
  end
end
