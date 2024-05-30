# frozen_string_literal: true

class Activity
  class Trigger < ApplicationRecord
    self.table_name = :nav_activity_triggers

    belongs_to :activity,
               class_name: '::Activity',
               foreign_key: :nav_activity_id,
               inverse_of: :activity_triggers

    belongs_to :questionnaire,
               class_name: '::Questionnaire',
               foreign_key: :nav_questionnaire_id,
               inverse_of: :activity_triggers
  end
end
