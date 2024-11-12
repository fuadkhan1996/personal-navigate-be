# frozen_string_literal: true

class Assessment
  class EvaluatorService < ApplicationService
    attr_reader :assessment, :triggers, :trigger, :retained_action_results

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
      @retained_action_results = []
    end

    def call
      criteria_met = false
      ActiveRecord::Base.transaction do
        triggers.each do |trig|
          @trigger = trig
          next unless criteria_met?

          criteria_met = true
          create_action_results
        end

        raise ActiveRecord::Rollback unless criteria_met
      end

      soft_delete_unretained_action_results if criteria_met

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

    def create_action_results
      activity.activity_actions.each do |activity_action|
        action_result = Assessment::ActionResult.find_or_create_by!(
          nav_assessment_id: assessment.id,
          nav_activity_action_id: activity_action.id
        )

        retained_action_results << action_result

        Assessment::ActionResultTrigger.find_or_create_by!(
          assessment_action_result_id: action_result.id,
          activity_trigger_id: trigger.id
        )
      end
    end

    def soft_delete_unretained_action_results
      unretained_action_results.soft_delete
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

    def unretained_action_results
      Assessment::ActionResult.by_assessments([assessment.id]).ids_not_in(retained_action_results.map(&:id))
    end
  end
end
