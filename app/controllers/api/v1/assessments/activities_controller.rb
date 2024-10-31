# frozen_string_literal: true

module Api
  module V1
    module Assessments
      class ActivitiesController < ApplicationController
        before_action :authorize_assessment!
        before_action :set_activity, only: :show
        before_action :authorize_activity!, only: :show

        def index
          scope = if params[:assessment_id].present?
                    activities_by_assessment
                  else
                    Activity.accessible_by(current_ability).with_assessment_action_results(assessments.ids)
                  end

          @activities = scope.includes(:company, :company_employee)
          render json: ::ActivityBlueprint.render(
            @activities,
            view: :with_assessment_id_and_status
          ), status: :ok
        end

        def show
          render json: ::ActivityBlueprint.render(
            @activity,
            view: :with_assessment_action_results,
            assessment_ids: [assessment.id]
          ), status: :ok
        end

        private

        def assessments
          @assessments ||= Assessment.accessible_by(current_ability)
        end

        def activities
          @activities ||= Activity.accessible_by(current_ability)
        end

        def assessment
          @assessment ||= assessments.find_by(id: params[:assessment_id])
        end

        def activities_by_assessment
          @activities_by_assessment ||= activities.with_assessment_action_results([assessment.id])
        end

        def set_activity
          @activity = activities_by_assessment.find_by(id: params[:id])
        end

        def authorize_assessment!
          authorize! :read, assessment if params[:assessment_id].present?
        end

        def authorize_activity!
          authorize! :read, @activity
        end
      end
    end
  end
end
