# frozen_string_literal: true

class Activity < ApplicationRecord
  self.table_name = :nav_activities

  attr_accessor :dc_company,
                :dc_company_employee

  has_many :activity_actions,
           dependent: :restrict_with_exception,
           class_name: 'Activity::Action',
           foreign_key: :nav_activity_id,
           inverse_of: :activity

  has_many :activity_triggers,
           dependent: :restrict_with_exception,
           class_name: 'Activity::Trigger',
           foreign_key: :nav_activity_id,
           inverse_of: :activity
end
