# frozen_string_literal: true

class Assessment
  class EvaluatorService < ApplicationService
    attr_reader :assessment, :triggers, :trigger, :retained_associated_activities

    OPERATIONS = {
      'eq' => ->(data, condition) { data.to_s == condition.to_s },
      'lt' => ->(data, condition) { data.to_f < condition.to_f },
      'gt' => ->(data, condition) { data.to_f > condition.to_f },
      'gteq' => ->(data, condition) { data.to_f >= condition.to_f },
      'lteq' => ->(data, condition) { data.to_f <= condition.to_f },
      'cont' => ->(data, condition) { condition.all? { |value| data.include?(value) } }
    }.freeze

    def initialize(assessment, triggers)
      super()
      @assessment = assessment
      @triggers = Array(triggers)
      @retained_associated_activities = []
    end

    def call
      criteria_met = false
      ActiveRecord::Base.transaction do
        triggers.each do |trig|
          @trigger = trig
          next unless criteria_met?

          criteria_met = true
          create_associated_activities
        end

        raise ActiveRecord::Rollback unless criteria_met
      end

      criteria_met
    end

    def self.call(assessment:, triggers:)
      new(assessment, triggers).call
    end

    private

    def evaluate_condition(condition)
      key = condition['key']
      value = condition['value']
      operator = condition['operator']
      return false if form_data[key].blank? || form_data[key].to_s.strip.empty?

      compare_values(form_data[key], operator, value)
    end

    def compare_values(data_value, operator, condition_value)
      operation = OPERATIONS[operator]
      operation ? operation.call(data_value, condition_value) : false
    end

    def criteria_met?
      results = conditions.map { |condition| evaluate_condition(condition) }
      conjunction == 'and' ? results.all? : results.any?
    end

    def create_associated_activities
      associated_activity = activity.activity_connections.find_or_create_by!(assessment_id: assessment.id)
      retained_associated_activities << associated_activity
      associated_activity.associated_activity_triggers.find_or_create_by!(activity_trigger_id: trigger.id)
    end

    def activity
      trigger.activity
    end

    def criteria
      trigger.criteria
    end

    def conditions
      criteria['conditions']
    end

    def conjunction
      criteria['conjunction']
    end

    def form_data
      assessment.form_data
    end
  end
end
