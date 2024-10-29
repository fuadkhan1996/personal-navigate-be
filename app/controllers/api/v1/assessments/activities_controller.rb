# frozen_string_literal: true

module Api
  module V1
    module Assessments
      class ActivitiesController < ApplicationController
        before_action :set_activity, only: :show

        def index
          scope = if params[:assessment_id].present?
                    assessment.activities_with_assessment_action_results
                  else
                    Activity.accessible_by(current_ability).with_assessment_action_results
                  end

          @activities = scope.includes(assessment_action_results: %i[activity_trigger activity_action])
          render json: ::ActivityBlueprint.render(@activities, view: :with_assessment_action_results), status: :ok
        end

        def show
          render json: ::ActivityBlueprint.render(@activity, view: :with_assessment_action_results), status: :ok
        end

        private

        def assessment
          @assessment ||= Assessment.accessible_by(current_ability).find_by(id: params[:assessment_id])
        end

        def set_activity
          @activity = assessment.activities_with_assessment_action_results.find_by(id: params[:id])
        end
      end
    end
  end
end
