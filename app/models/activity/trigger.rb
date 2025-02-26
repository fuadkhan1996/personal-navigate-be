# frozen_string_literal: true

class Activity
  class Trigger < ApplicationRecord
    self.table_name = :nav_activity_triggers

    belongs_to :activity, class_name: '::Activity', inverse_of: :activity_triggers
    belongs_to :trigger, class_name: '::Trigger', inverse_of: :activity_triggers

    validates :activity_id, uniqueness: { case_sensitive: false, scope: :trigger_id }
  end
end
