# frozen_string_literal: true

module Api
  module V1
    module Assessments
      class TriggersController < ApplicationController
        before_action :set_trigger, only: %i[evaluate_trigger]

        def evaluate_triggers
          if Assessment::Evaluator.call(assessment:, triggers: assessment.activity_triggers)
            render json: ::Assessment::ActionResultBlueprint.render(assessment.assessment_action_results), status: :ok
          else
            render json: { success: false, message: 'Criteria not met or action failed' }, status: :unprocessable_entity
          end
        end

        def evaluate_trigger
          if Assessment::Evaluator.call(assessment:, triggers: @trigger)
            render json: ::Assessment::ActionResultBlueprint.render(assessment.assessment_action_results), status: :ok
          else
            render json: { success: false, message: 'Criteria not met or action failed' }, status: :unprocessable_entity
          end
        end

        private

        def assessment
          @assessment ||= Assessment.accessibly_by(current_ability).find(params[:assessment_id])
        end

        def set_trigger
          @trigger = assessment.activity_triggers.find(params[:id])
        end
      end
    end
  end
end
