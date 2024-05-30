# frozen_string_literal: true

class Assessment
  class ActionResult < ApplicationRecord
    self.table_name = :nav_assessment_action_results

    belongs_to :activity_action,
               class_name: '::Activity::Action',
               foreign_key: :nav_activity_action_id,
               inverse_of: :assessment_action_results

    belongs_to :assessment,
               class_name: '::Assessment',
               foreign_key: :nav_assessment_id,
               inverse_of: :assessment_action_results
  end
end
