# frozen_string_literal: true

module Api
  module V1
    module Assessments
      class TriggersController < ApplicationController
        before_action :authorize_assessment!
        before_action :set_trigger, only: %i[evaluate_trigger]

        def evaluate_triggers
          if Assessment::EvaluatorService.call(assessment:, triggers: assessment.activity_triggers.active)
            render json: AssociatedActivityBlueprint.render(assessment.associated_activities), status: :ok
          else
            render json: { success: false, message: 'Criteria not met or action failed' }, status: :unprocessable_entity
          end
        end

        def evaluate_trigger
          if Assessment::EvaluatorService.call(assessment:, triggers: @trigger)
            render json: AssociatedActivityBlueprint.render(assessment.associated_activities), status: :ok
          else
            render json: { success: false, message: 'Criteria not met or action failed' }, status: :unprocessable_entity
          end
        end

        private

        def assessment
          @assessment ||= Assessment.accessible_by(current_ability).find_by(id: params[:assessment_id])
        end

        def set_trigger
          @trigger = assessment.activity_triggers.active.find(params[:id])
        end

        def authorize_assessment!
          authorize! :read, assessment
        end
      end
    end
  end
end
