# frozen_string_literal: true

class Activity
  class Trigger < ApplicationRecord
    self.table_name = :nav_activity_triggers

    OPERATORS = %w[eq lt gt gteq lteq].freeze

    belongs_to :activity,
               class_name: '::Activity',
               foreign_key: :nav_activity_id,
               inverse_of: :activity_triggers

    belongs_to :questionnaire,
               class_name: '::Questionnaire',
               foreign_key: :nav_questionnaire_id,
               inverse_of: :activity_triggers

    has_many :assessment_action_result_triggers,
             dependent: :destroy,
             class_name: 'Assessment::ActionResultTrigger',
             foreign_key: :activity_trigger_id,
             inverse_of: :activity_trigger

    has_many :assessment_action_results, through: :assessment_action_result_triggers

    delegate :title, to: :questionnaire, prefix: true

    validates :title, :criteria, presence: true
    validate :validate_criteria

    scope :for_company, ->(company_id) { joins(:activity).where(nav_activities: { dc_company_id: company_id }) }

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
end
