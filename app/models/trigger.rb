# frozen_string_literal: true

class Trigger < ApplicationRecord
  self.table_name = :nav_triggers

  include SoftDeletable

  OPERATORS = %w[eq lt gt gteq lteq cont].freeze

  belongs_to :company, class_name: 'Dc::Company'
  belongs_to :company_employee, class_name: 'Dc::CompanyEmployee'
  belongs_to :questionnaire,
             class_name: '::Questionnaire',
             foreign_key: :nav_questionnaire_id,
             inverse_of: :triggers

  has_many :activity_triggers, dependent: :destroy, class_name: 'Activity::Trigger'
  has_many :associated_activity_triggers,
           dependent: :destroy,
           class_name: 'AssociatedActivity::Trigger',
           foreign_key: :activity_trigger_id,
           inverse_of: :trigger

  validates :title, :criteria, presence: true
  validates :title, uniqueness: { case_sensitive: false, scope: :company_id }
  validate :validate_criteria, unless: :deleted?

  scope :for_company, ->(company_id) { where(company_id:) }

  delegate :title, to: :questionnaire, prefix: true

  private

  def validate_criteria
    conditions = criteria['conditions']
    return errors.add(:'criteria.conditions', "can't be blank") if conditions.blank?
    return errors.add(:'criteria.conditions', 'should be an array') unless conditions.is_a?(Array)

    conditions.each_with_index do |condition, index|
      validate_condition(condition, index)
    end
  end

  def validate_condition(condition, index)
    %w[key operator value].each do |field|
      errors.add(:"criteria.conditions.#{index}.#{field}", "can't be blank") if condition[field].blank?
    end

    return if OPERATORS.include?(condition['operator'])

    errors.add(:"criteria.conditions.#{index}.operator", 'incorrect operator')
  end
end
