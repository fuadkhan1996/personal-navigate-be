# frozen_string_literal: true

class AssociatedActivity
  class Trigger < ApplicationRecord
    self.table_name = :nav_assessment_action_result_triggers

    belongs_to :associated_activity, class_name: '::AssociatedActivity'
    belongs_to :activity_trigger, class_name: '::Activity::Trigger'

    # validates :activity_trigger_id, uniqueness: { scope: :associated_activity_id }
  end
end
