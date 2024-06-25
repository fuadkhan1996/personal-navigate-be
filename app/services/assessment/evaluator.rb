# frozen_string_literal: true

class Assessment
  class Evaluator
    attr_reader :assessment, :trigger

    def initialize(assessment, trigger)
      @assessment = assessment
      @trigger = trigger
    end

    def call
      ActiveRecord::Base.transaction do
        raise ActiveRecord::Rollback unless criteria_met?

        create_action_results
      end
    end

    def self.call(assessment:, trigger:)
      new(assessment, trigger).call
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
      case operator
      when 'eq'
        data_value.to_s == condition_value.to_s
      when 'lt'
        data_value.to_f < condition_value.to_f
      when 'gt'
        data_value.to_f > condition_value.to_f
      when 'gteq'
        data_value.to_f >= condition_value.to_f
      when 'lteq'
        data_value.to_f <= condition_value.to_f
      else
        false
      end
    end

    def criteria_met?
      results = conditions.map { |condition| evaluate_condition(condition) }
      conjunction == 'and' ? results.all? : results.any?
    end

    def create_action_results
      activity.activity_actions.each do |activity_action|
        Assessment::ActionResult.find_or_create_by!(
          nav_activity_trigger_id: trigger.id,
          nav_assessment_id: assessment.id,
          nav_activity_action_id: activity_action.id
        )
      end
    end

    def activity
      @activity ||= trigger.activity
    end

    def criteria
      @criteria ||= trigger.criteria
    end

    def conditions
      @conditions ||= criteria['conditions']
    end

    def conjunction
      @conjunction ||= criteria['conjunction']
    end

    def form_data
      @form_data ||= assessment.form_data
    end
  end
end
