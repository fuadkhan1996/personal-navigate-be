# frozen_string_literal: true

class Activity < ApplicationRecord
  self.table_name = :nav_activities

  belongs_to :company, class_name: 'Dc::Company', foreign_key: :dc_company_id, inverse_of: :activities

  belongs_to :company_employee,
             class_name: 'Dc::CompanyEmployee',
             foreign_key: :dc_company_employee_id,
             inverse_of: :activities

  has_many :activity_actions,
           dependent: :destroy,
           class_name: 'Activity::Action',
           foreign_key: :nav_activity_id,
           inverse_of: :activity

  has_many :activity_triggers,
           dependent: :destroy,
           class_name: 'Activity::Trigger',
           inverse_of: :activity

  has_many :triggers, through: :activity_triggers
  has_many :activity_connections,
           dependent: :destroy,
           class_name: 'AssociatedActivity',
           inverse_of: :activity

  has_many :assigned_companies, through: :activity_connections, source: :company
  has_many :assessment_action_results, through: :activity_actions
  has_many :assessments, through: :activity_connections

  accepts_nested_attributes_for :activity_actions

  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: false, scope: :dc_company_id }
  validates :activity_actions, presence: true, on: :create
  validates_associated :activity_actions

  scope :by_action_kind, ->(action_kind) { joins(activity_actions: :action).where(nav_actions: { action_kind: }) }
end
