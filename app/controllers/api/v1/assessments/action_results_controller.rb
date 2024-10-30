# frozen_string_literal: true

module Api
  module V1
    module Assessments
      class ActionResultsController < ApplicationController
        before_action :set_action_result, only: %i[update]

        def update
          Assessment::UpdateActionResultService.call(
            action_result: @action_result,
            params: update_params.to_h.with_indifferent_access
          )

          if @action_result.errors.any?
            unprocessable_entity(@action_result.errors.messages)
          else
            render json: ::Assessment::ActionResultBlueprint.render(@action_result, view: :with_activity), status: :ok
          end
        end

        private

        def update_params
          params.require(:action_result).permit(result_data: {})
        end

        def assessment
          @assessment ||= Assessment.accessible_by(current_ability).find_by(id: params[:assessment_id])
        end

        def set_action_result
          @action_result = assessment.assessment_action_results.find_by(id: params[:id])
        end
      end
    end
  end
end
