# frozen_string_literal: true

module Api
  module V1
    module Activities
      class TriggersController < ApplicationController
        before_action :authorize_activity!
        before_action :set_trigger, only: %i[show destroy]

        def index
          @triggers = activity.activity_triggers.active.order(created_at: :desc)
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

        def destroy
          if @trigger.soft_delete
            render json: { id: @trigger.id, message: 'Activity trigger deleted Successfully.' }, status: :ok
          else
            unprocessable_entity(@trigger.errors.messages)
          end
        end

        private

        def activity
          @activity ||= Activity.accessible_by(current_ability).find_by(id: params[:activity_id])
        end

        def set_trigger
          @trigger = activity.activity_triggers.active.find(params[:id])
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

        def authorize_activity!
          authorize! :read, activity
        end
      end
    end
  end
end
