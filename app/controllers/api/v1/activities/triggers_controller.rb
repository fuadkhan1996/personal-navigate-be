# frozen_string_literal: true

module Api
  module V1
    module Activities
      class TriggersController < ApplicationController
        before_action :set_trigger, only: %i[show]

        def index
          @triggers = activity.activity_triggers.order(created_at: :desc)
          render json: ::Activity::TriggerBlueprint.render(@triggers), status: :ok
        end

        def show
          render json: ::Activity::TriggerBlueprint.render(@trigger), status: :ok
        end

        def create
          @trigger = activity.activity_triggers.new(trigger_create_params)
          if @trigger.save
            render json: { id: @trigger.id, message: 'Activity trigger created Successfully.' }, status: :created
          else
            unprocessable_entity(@trigger.errors.messages)
          end
        end

        private

        def activity
          @activity ||= Activity.accessibly_by(current_ability).find(params[:activity_id])
        end

        def set_trigger
          @trigger = activity.activity_triggers.find(params[:id])
        end

        def trigger_create_params
          params.require(:activity_trigger).permit(
            :nav_questionnaire_id,
            :title,
            :description,
            { criteria: {} }
          ).tap do |transformed_params|
            transformed_params[:criteria] = parse_and_permit_criteria(transformed_params[:criteria])
          end
        end

        def parse_and_permit_criteria(criteria)
          if criteria.is_a?(String)
            begin
              parsed_criteria = JSON.parse(criteria)
              ActionController::Parameters.new(parsed_criteria)
                                          .permit(:conjunction, conditions: %i[key operator value])
            rescue JSON::ParserError
              {}
            end
          else
            criteria
          end
        end
      end
    end
  end
end
