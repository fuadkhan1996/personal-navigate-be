# frozen_string_literal: true

module Api
  module V1
    module Activities
      class TriggersController < ApplicationController
        before_action :authorize_activity!
        before_action :set_activity_trigger, only: %i[show destroy]

        def index
          @activity_triggers = activity.activity_triggers.includes(:trigger).order(created_at: :desc)
          render json: ::Activity::TriggerBlueprint.render(@activity_triggers), status: :ok
        end

        def show
          render json: ::Activity::TriggerBlueprint.render(@activity_trigger), status: :ok
        end

        def create
          @activity_trigger = activity.activity_triggers.new(trigger_create_params)
          if @activity_trigger.save
            render json: { id: @activity_trigger.id, message: 'Triggers added Successfully.' },
                   status: :created
          else
            unprocessable_entity(@activity_trigger.errors.messages)
          end
        end

        def destroy
          if @activity_trigger.destroy
            render json: { id: @activity_trigger.id, message: 'Activity trigger deleted Successfully.' }, status: :ok
          else
            unprocessable_entity(@activity_trigger.errors.messages)
          end
        end

        private

        def activity
          @activity ||= Activity.accessible_by(current_ability).find_by(id: params[:activity_id])
        end

        def set_activity_trigger
          @activity_trigger = activity.activity_triggers.find(params[:id])
        end

        def trigger_create_params
          params.permit(:activity_id, activity_trigger: [:trigger_id]).require(:activity_trigger)
        end

        def authorize_activity!
          authorize! :read, activity
        end
      end
    end
  end
end
