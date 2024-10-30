# frozen_string_literal: true

class Activity < ApplicationRecord
  self.table_name = :nav_activities

  belongs_to :company, class_name: 'Dc::Company', foreign_key: :dc_company_id, inverse_of: :activities

  belongs_to :company_employee,
             class_name: 'Dc::CompanyEmployee',
             foreign_key: :dc_company_employee_id,
             inverse_of: :activities

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

  has_many :assessment_action_results, through: :activity_actions
  has_many :assessments, through: :assessment_action_results

  accepts_nested_attributes_for :activity_actions

  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: false, scope: :dc_company_id }
  validates :activity_actions, presence: true, on: :create
  validates_associated :activity_actions

  scope :with_assessment_action_results, lambda {
    joins(:assessment_action_results)
      .select(
        "nav_activities.*,
       nav_assessment_action_results.nav_assessment_id AS assessment_id,
       CASE
         WHEN COUNT(nav_assessment_action_results.id) = COUNT(nav_assessment_action_results.completed_at)
           THEN 'Complete'
         WHEN COUNT(nav_assessment_action_results.completed_at) > 0
           THEN 'In Progress'
         ELSE 'InComplete'
       END AS status"
      )
      .group('nav_activities.id', 'nav_assessment_action_results.nav_assessment_id')
  }
end
