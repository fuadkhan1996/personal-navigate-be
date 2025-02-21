# frozen_string_literal: true

class Assessment
  class ActionResultTrigger < ApplicationRecord
    self.table_name = :nav_assessment_action_result_triggers

    belongs_to :activity_trigger,
               class_name: '::Activity::Trigger',
               inverse_of: :assessment_action_result_triggers

    belongs_to :assessment_action_result,
               class_name: '::Assessment::ActionResult',
               inverse_of: :assessment_action_result_triggers

    # validates :activity_trigger_id, uniqueness: { scope: :assessment_action_result_id }
  end
end
