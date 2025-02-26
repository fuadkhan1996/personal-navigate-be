# frozen_string_literal: true

class AssociatedActivity
  class Trigger < ApplicationRecord
    self.table_name = :nav_assessment_action_result_triggers

    belongs_to :associated_activity, class_name: '::AssociatedActivity'
    belongs_to :trigger,
               class_name: '::Trigger',
               foreign_key: :activity_trigger_id,
               inverse_of: :associated_activity_triggers

    # validates :activity_trigger_id, uniqueness: { scope: :associated_activity_id }
  end
end
